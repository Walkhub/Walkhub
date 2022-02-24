import Foundation

import RxSwift

public class SigninUseCase {

    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    public func excute(id: String, password: String) -> Completable {
        authRepository.signin(id: id, password: password)
    }

}
