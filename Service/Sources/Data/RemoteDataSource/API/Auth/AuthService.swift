import Foundation

import Moya
import RxSwift

final class AuthService: BaseService<AuthAPI> {

    static let shared = AuthService()

    private override init() {}

    func renewalToken() -> Single<Response> {
        return request(.renewalToken)
    }

}
