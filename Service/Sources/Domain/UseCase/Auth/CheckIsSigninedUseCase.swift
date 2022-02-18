import Foundation

import RxSwift

public class CheckIsSigninedUseCase {

    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    public func excute() -> Completable {
        authRepository.tokenRefresh()
    }

}
