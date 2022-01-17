import Foundation

import FirebaseMessaging
import RxSwift
import Moya

class DefaultAuthRepository: AuthRepository {

    func signin(
        id: String,
        password: String
    ) -> Single<Void> {
        return fetchDeviceToken()
            .flatMap { deviceToken in
                return AuthService.shared.signin(
                    id: id,
                    password: password,
                    deviceToken: deviceToken
                )
            }.map { _ in
                return ()
            }.catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError.errorCode {
                    case 404: return Single.error(WalkhubError.faildSignin)
                    default: return Single.error(error)
                    }
                } else {  return Single.error(error) }
            }
    }

    func signup(
        id: String,
        password: String,
        name: String,
        phoneNumber: String,
        authCode: String
    ) -> Single<Void> {
        return AuthService.shared.signup(
            id: id,
            password: password,
            name: name,
            phoneNumber: phoneNumber,
            authCode: authCode
        ).map { _ in
            return ()
        }.catch { error in
            if let moyaError = error as? MoyaError {
                switch moyaError.errorCode {
                case 404: return Single.error(WalkhubError.invalidAuthCode)
                case 409: return Single.error(WalkhubError.duplicateId)
                default: return Single.error(error)
                }
            } else {  return Single.error(error) }
        }
    }

    func verificationPhone(phoneNumber: String) -> Single<Void> {
        return AuthService.shared.verificationPhone(
            phoneNumber: phoneNumber
        ).map { _ in return () }
    }

}

extension DefaultAuthRepository {
    private func fetchDeviceToken() -> Single<String> {
        return Single<String>.create { single in
            Messaging.messaging().token { token, _ in
                single(.success(token ?? ""))
            }
            return Disposables.create()
        }
    }
}
