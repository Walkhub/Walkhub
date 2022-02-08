// swiftlint:disable function_parameter_count
import Foundation

import RxSwift

protocol AuthRepository {
    func signin(id: String, password: String) -> Single<Void>
    func signup(id: String, password: String, name: String, phoneNumber: String, authCode: String, height: Float,
                weight: Int, birthday: String, sex: Sex, schoolId: String) -> Single<Void>
    func verificationPhone(phoneNumber: String) -> Single<Void>
}
