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
    ) -> Single<UserSinginResponseDTO> {
        return request(.signin(
            id: id,
            password: password,
            deviceToken: deviceToken
        )).map(UserSinginResponseDTO.self)
    }

    func signup(
        id: String,
        password: String,
        name: String,
        phoneNumber: String,
        authCode: String,
        height: Float?,
        weight: Int?,
        sex: Sex,
        schoolId: Int
    ) -> Completable {
        return request(.signup(
            id: id,
            password: password,
            name: name,
            phoneNumber: phoneNumber,
            authCode: authCode,
            height: height,
            weight: weight,
            sex: sex,
            schoolId: schoolId
        )).asCompletable()
    }

    func verificationPhone(phoneNumber: String) -> Completable {
        return request(.verificationPhone(phoneNumber: phoneNumber))
            .asCompletable()
    }

    func renewalToken() -> Completable {
        return request(.renewalToken)
            .asCompletable()
    }

    func findID(phoneNumber: String) -> Single<String> {
        return request(.findID(phoneNumber: phoneNumber))
            .map(UserIdDTO.self)
            .map { $0.toDomain() }
    }

    func checkVerificationCode(verificationCode: String, phoneNumber: String) -> Completable {
        return request(.checkVerificationCode(
            verificationCode: verificationCode,
            phoneNumber: phoneNumber
        )).asCompletable()
    }

    func checkAccountId(accountId: String) -> Completable {
        return request(.checkAccountId(accountId: accountId))
            .asCompletable()
    }
}
