import Foundation

import Moya
import RxSwift

final class AuthService: BaseService<AuthAPI> {

    static let shared = AuthService()

    private override init() {}

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
        authCode: String
    ) -> Single<Response> {
        return request(.signup(
            id: id,
            password: password,
            name: name,
            phoneNumber: phoneNumber,
            authCode: authCode
        ))
    }

    func verificationPhone(phoneNumber: String) -> Single<Response> {
        return request(.verificationPhone(phoneNumber: phoneNumber))
    }

    func renewalToken() -> Single<Response> {
        return request(.renewalToken)
    }

}
