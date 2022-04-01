import Foundation

import RxSwift

public class CheckVerificationCodeUseCase {

    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    public func excute(
        verificationCode: String,
        phoneNumber: String
    ) -> Completable {
        return authRepository.checkVerificationCode(
            verificationCode: verificationCode,
            phoneNumber: phoneNumber
        )
    }
}
