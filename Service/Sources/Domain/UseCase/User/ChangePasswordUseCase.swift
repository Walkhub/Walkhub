import Foundation

import RxSwift

public class ChangePasswordUseCase {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(
        password: String,
        newPassword: String
    ) -> Completable {
        return userRepository.changePassword(password: password, newPassword: newPassword)
    }
}
