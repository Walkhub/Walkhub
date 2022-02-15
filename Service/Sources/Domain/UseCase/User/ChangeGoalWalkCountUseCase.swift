import Foundation

import RxSwift

public class ChangeGoalWalkCountUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(goalWalkCount: Int) -> Completable {
        userRepository.changeGoalWalkCount(goalWalkCount: goalWalkCount)
    }
}
