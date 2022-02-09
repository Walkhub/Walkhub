import Foundation

import RxSwift

public class SetMainBadgeUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(badgeId: Int) -> Single<Void> {
        userRepository.setMainBadge(badgeId: badgeId)
    }

}
