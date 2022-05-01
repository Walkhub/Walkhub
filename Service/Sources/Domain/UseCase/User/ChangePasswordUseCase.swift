import Foundation

import RxSwift

public class ChangePasswordUseCase {
    private let userRepositroy: UserRepository

    init(userRepository: UserRepository) {
        self.userRepositroy = userRepository
    }

    public func excute(
        password: String,
        newPassword: String
    ) -> Completable {
        return userRepositroy.changePassword(
            password: password,
            newPassword: newPassword
        )
    }
}
