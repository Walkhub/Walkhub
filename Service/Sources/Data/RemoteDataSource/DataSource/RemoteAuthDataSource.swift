import Foundation

import Moya
import RxSwift

final class RemoteAuthDataSource: RemoteBaseDataSource<AuthAPI> {

    static let shared = RemoteAuthDataSource()

    private override init() { }

    func signin(
        id: String,
        password: String,
        deviceToken: String
    ) -> Single<Response> {
        return request(.signin(
            id: id,
            password: password,
            deviceToken: deviceToken
        ))
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
        sex: String,
        agencyCode: String
    ) -> Single<Response> {
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
            agencyCode: agencyCode
        ))
    }

    func verificationPhone(phoneNumber: String) -> Single<Response> {
        return request(.verificationPhone(phoneNumber: phoneNumber))
    }

    func renewalToken() -> Single<Response> {
        return request(.renewalToken)
    }

    func findID(phoneNumber: String) -> Single<Response> {
        return request(.findID(phoneNumber: phoneNumber))
    }

}
