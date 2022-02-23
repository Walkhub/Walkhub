import Foundation

import Moya
import RxCocoa
import RxMoya
import RxSwift

class RestApiRemoteDataSource<API: WalkhubAPI> {

    private let provider = MoyaProvider<API>(plugins: [JWTPlugin()])

    private let keychainDataSource = KeychainDataSource.shared

    func request(_ api: API) -> Single<Response> {
        return Single<Response>.create { single in
            var disposabels = [Disposable]()
            if self.checkApiIsNeedAccessToken(api) {
                disposabels.append(
                    self.requestWithAccessToken(api)
                        .subscribe(
                            onSuccess: { single(.success($0)) },
                            onFailure: { single(.failure($0)) })
                )
            } else {
                disposabels.append(
                    self.defaultRequest(api).subscribe(
                        onSuccess: { single(.success($0)) },
                        onFailure: { single(.failure($0)) })
                )
            }
            return Disposables.create(disposabels)
        }
    }

}

private extension RestApiRemoteDataSource {

    private func defaultRequest(_ api: API) -> Single<Response> {
        return provider.rx.request(api)
            .timeout(.seconds(5), scheduler: MainScheduler.asyncInstance)
            .catch { error in
                guard let errorCode = (error as? MoyaError)?.response?.statusCode else {
                    return Single.error(error)
                }
                return Single.error(api.errorMapper?[errorCode] ?? error)
            }
    }

    private func requestWithAccessToken(_ api: API) -> Single<Response> {
        return Single.deferred {
            do {
                if try self.checkTokenIsValid() {
                    return self.defaultRequest(api)
                } else {
                    return .error(TokenError.tokenExpired)
                }
            } catch {
                return .error(error)
            }
        }
        .retry(when: { (errorObservable: Observable<TokenError>) in
            return errorObservable
                .flatMap { error -> Observable<Void> in
                switch error {
                case .tokenExpired:
                    return self.renewalToken()
                        .andThen(.just(()))
                default:
                    return .error(error)
                }
            }
        })
    }

}

extension RestApiRemoteDataSource {

    private func checkApiIsNeedAccessToken(_ api: API) -> Bool {
        return api.jwtTokenType == JWTTokenType.accessToken
    }

    private func checkTokenIsValid() throws -> Bool {
        do {
            let expiredDate = try keychainDataSource.fetchExpiredDate()
            return Date() <= expiredDate
        } catch {
            throw TokenError.noToken
        }
    }

    private func renewalToken() -> Completable {
        return MoyaProvider<AuthAPI>(plugins: [JWTPlugin()]).rx
            .request(.renewalToken)
            .asCompletable()
    }

}
