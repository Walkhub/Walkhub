import Foundation

import RxSwift

public class CheckAccountIdUseCase {

    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    public func excute(accountId: String) -> Completable {
        return authRepository.checkAccountId(accountId: accountId)
    }
}
