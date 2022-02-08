import Foundation

import RxSwift

public class SinginUseCase {

    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    public func excute(id: String, password: String) -> Single<Void> {
        authRepository.signin(id: id, password: password)
    }
}
