import Foundation

import RxSwift

public class SetMainBadgeUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(badgeId: Int) -> Completable {
        userRepository.setMainBadge(badgeId: badgeId)
    }

}
