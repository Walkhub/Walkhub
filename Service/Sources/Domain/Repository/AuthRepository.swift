import Foundation

import RxSwift

protocol AuthRepository {
    func singing(id: String, password: String, deviceToken: String) -> Single<Void>
    func singing(id: String, password: String, name: String, phoneNumber: String, authCode: String) -> Single<Void>
    func verificationPhone(phoneNumber: String) -> Single<Void>
}
