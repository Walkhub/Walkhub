import Foundation

import RxSwift

public class VerificationPhoneUseCase {

    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    public func excute(phoneNumber: String) -> Completable {
        authRepository.verificationPhone(phoneNumber: phoneNumber)
    }

}
