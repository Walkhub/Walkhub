// swiftlint:disable function_parameter_count
import Foundation

import RxSwift

protocol AuthRepository {
    func tokenRefresh() -> Completable
    func signin(id: String, password: String) -> Completable
    func signup(id: String, password: String, name: String, phoneNumber: String, authCode: String, height: Float?,
                weight: Int?, sex: Sex, schoolId: Int) -> Completable
    func verificationPhone(phoneNumber: String) -> Completable
    func checkVerificationCode(verificationCode: String, phoneNumber: String) -> Completable
    func checkAccountId(accountId: String) -> Completable
}
