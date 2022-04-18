// swiftlint:disable function_parameter_count
import Foundation

import FirebaseMessaging
import RxSwift
import Moya

class DefaultAuthRepository: AuthRepository {

    private let remoteAuthDataSource = RemoteAuthDataSource.shared
    private let keychainDataSource = KeychainDataSource.shared
    private let healthKitDataSource = HealthKitDataSource.shared
    private let userDefaultDataSource = UserDefaultsDataSource.shared

    func tokenRefresh() -> Completable {
        remoteAuthDataSource.renewalToken()
    }

    func signin(
        id: String,
        password: String
    ) -> Completable {
        return fetchDeviceToken()
            .flatMapCompletable { deviceToken in
                return self.remoteAuthDataSource.signin(
                    id: id,
                    password: password,
                    deviceToken: deviceToken
                ).do(onSuccess: {
                    print($0)
                    self.keychainDataSource.registerAccessToken($0.accessToken)
                    self.keychainDataSource.registerRefreshToken($0.refreshToken)
                    self.keychainDataSource.registerExpiredAt($0.expiredAt)
                    self.healthKitDataSource.storeUserHeight($0.height ?? 0)
                    self.healthKitDataSource.storeUserWeight(Double($0.weight ?? 0))
                    self.userDefaultDataSource.userSex = Sex(rawValue: $0.sex)!
                }, onError: {
                    print($0)
                }).asCompletable()
            }
    }

    func signup(
        id: String,
        password: String,
        name: String,
        phoneNumber: String,
        authCode: String,
        schoolId: Int
    ) -> Completable {
        return remoteAuthDataSource.signup(
            id: id,
            password: password,
            name: name,
            phoneNumber: phoneNumber,
            authCode: authCode,
            schoolId: schoolId
        ).do(onSuccess: {
            self.keychainDataSource.registerAccessToken($0.accessToken)
            self.keychainDataSource.registerRefreshToken($0.refreshToken)
            self.keychainDataSource.registerExpiredAt($0.expiredAt)
            self.healthKitDataSource.storeUserHeight($0.height ?? 0)
            self.healthKitDataSource.storeUserWeight(Double($0.weight ?? 0))
            self.userDefaultDataSource.userSex = Sex(rawValue: $0.sex)!
        }, onError: {
            print($0)
        }).asCompletable()
    }

    func verificationPhone(phoneNumber: String) -> Completable {
        return remoteAuthDataSource.verificationPhone(
            phoneNumber: phoneNumber
        )
    }

    func checkVerificationCode(verificationCode: String, phoneNumber: String) -> Completable {
        return remoteAuthDataSource.checkVerificationCode(
            verificationCode: verificationCode,
            phoneNumber: phoneNumber
        )
    }

    func checkAccountId(accountId: String) -> Completable {
        return remoteAuthDataSource.checkAccountId(accountId: accountId)
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
