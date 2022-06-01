import Foundation

import RxSwift

public class CheckClassCodeUseCase {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(_ classCode: String) -> Completable {
        return userRepository.checkClassCode(code: classCode)
    }
}
