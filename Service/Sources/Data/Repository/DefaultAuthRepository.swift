// swiftlint:disable function_parameter_count
import Foundation

import FirebaseMessaging
import RxSwift
import Moya

class DefaultAuthRepository: AuthRepository {

    func findId(phoneNumber: String) -> Single<Void> {
        return RemoteAuthDataSource.shared.findID(phoneNumber: phoneNumber)
            .map { _ in return () }
    }

    func renewalToken() -> Single<Void> {
        return RemoteAuthDataSource.shared.renewalToken()
            .map { _ in return () }
    }

    func signin(
        id: String,
        password: String
    ) -> Single<Void> {
        return fetchDeviceToken()
            .flatMap { deviceToken in
                return RemoteAuthDataSource.shared.signin(
                    id: id,
                    password: password,
                    deviceToken: deviceToken
                )
            }.map { _ in return () }
    }

    func signup(
        id: String,
        password: String,
        name: String,
        phoneNumber: String,
        authCode: String,
        height: Float,
        weight: Int,
        birthday: String,
        sex: Sex,
        schoolId: String
    ) -> Single<Void> {
        return RemoteAuthDataSource.shared.signup(
            id: id,
            password: password,
            name: name,
            phoneNumber: phoneNumber,
            authCode: authCode,
            height: height,
            weight: weight,
            birthday: birthday,
            sex: sex,
            schoolId: schoolId
        ).map { _ in return () }
    }

    func verificationPhone(phoneNumber: String) -> Single<Void> {
        return RemoteAuthDataSource.shared.verificationPhone(
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
