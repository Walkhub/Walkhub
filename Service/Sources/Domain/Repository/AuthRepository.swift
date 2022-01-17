import Foundation

import RxSwift

protocol AuthRepository {
    func signin(id: String, password: String) -> Single<Void>
    func signup(id: String, password: String, name: String, phoneNumber: String, authCode: String) -> Single<Void>
    func verificationPhone(phoneNumber: String) -> Single<Void>
}
