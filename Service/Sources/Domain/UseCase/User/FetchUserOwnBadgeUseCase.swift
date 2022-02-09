import Foundation

import RxSwift

public class FetchUserOwnBadgeUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(userId: Int) -> Observable<[Badge]> {
        userRepository.fetchBadges(userID: userId)
    }

}
