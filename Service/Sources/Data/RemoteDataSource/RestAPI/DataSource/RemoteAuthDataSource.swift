// swiftlint:disable function_parameter_count

import Foundation

import Moya
import RxSwift

final class RemoteAuthDataSource: RestApiRemoteDataSource<AuthAPI> {

    static let shared = RemoteAuthDataSource()

    private override init() { }

    func signin(
        id: String,
        password: String,
        deviceToken: String
    ) -> Single<Void> {
        return request(.signin(
            id: id,
            password: password,
            deviceToken: deviceToken
        )).map { _ in () }
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
        return request(.signup(
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
        )).map { _ in () }
    }

    func verificationPhone(phoneNumber: String) -> Single<Void> {
        return request(.verificationPhone(phoneNumber: phoneNumber))
            .map { _ in () }
    }

    func renewalToken() -> Single<Void> {
        return request(.renewalToken)
            .map { _ in () }
    }

    func findID(phoneNumber: String) -> Single<String> {
        return request(.findID(phoneNumber: phoneNumber))
            .map(UserIdDTO.self)
            .map { $0.toDomain() }
    }

}
