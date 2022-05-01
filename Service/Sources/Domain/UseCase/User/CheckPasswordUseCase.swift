import Foundation

import RxSwift

public class CheckPasswordUseCase {
    private let userRepositroy: UserRepository

    init(userRepository: UserRepository) {
        self.userRepositroy = userRepository
    }

    public func excute(currentPw: String) ->  Completable {
        return userRepositroy.checkPassword(currentPw: currentPw)
    }
}
