import Foundation

import Moya
import RxCocoa
import RxMoya
import RxSwift

class RestApiRemoteDataSource<API: WalkhubAPI> {

    private let provider = MoyaProvider<API>(plugins: [JWTPlugin()])

    func request(_ api: API) -> Single<Response> {
        return Single<Response>.create { single in
            var disposabels = [Disposable]()
            if self.checkApiIsAuthorizable(api) {
                disposabels.append(
                    self.authorizableRequest(api)
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
                guard let moyaError = error as? MoyaError else {
                    return Single.error(error)
                }
                return Single.error(api.errorMapper?[moyaError.errorCode] ?? error)
            }
    }

    private func authorizableRequest(_ api: API) -> Single<Response> {
        return Single<Response>.create { single in
            var disposables = [Disposable]()
            do {
                if try self.checkTokenIsValid() {
                    disposables.append(
                        self.defaultRequest(api).subscribe(
                            onSuccess: { single(.success($0)) },
                            onFailure: { single(.failure($0)) })
                    )
                } else {
                    single(.failure(TokenError.tokenExpired))
                }
            } catch {
                single(.failure(error))
            }
            return Disposables.create(disposables)
        }.retry(when: { (errorObservable: Observable<TokenError>) in
            errorObservable.flatMap { error -> Completable in
                if error == .tokenExpired {
                    return RemoteAuthDataSource.shared.renewalToken()
                } else {
                    throw TokenError.noToken
                }
            }
        })
    }

}

extension RestApiRemoteDataSource {

    private func checkApiIsAuthorizable(_ api: API) -> Bool {
        return !(api.jwtTokenType == JWTTokenType.none)
    }

    private func checkTokenIsValid() throws -> Bool {
        do {
            let expiredDate = try KeychainDataSource.shared.fetchExpiredDate()
            return expiredDate <= Date()
        } catch {
            throw TokenError.noToken
        }
    }

}
