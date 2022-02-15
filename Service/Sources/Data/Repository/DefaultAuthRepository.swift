// swiftlint:disable function_parameter_count
import Foundation

import FirebaseMessaging
import RxSwift
import Moya

class DefaultAuthRepository: AuthRepository {

    private let remoteAuthDataSource = RemoteAuthDataSource.shared

    func signin(
        id: String,
        password: String
    ) -> Single<Void> {
        return fetchDeviceToken()
            .flatMap { deviceToken in
                return self.remoteAuthDataSource.signin(
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
        return remoteAuthDataSource.signup(
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
        return remoteAuthDataSource.verificationPhone(
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
