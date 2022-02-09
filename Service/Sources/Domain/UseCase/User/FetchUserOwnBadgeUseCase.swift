import Foundation

import RxSwift

class FetchUserOwnBadgeUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func excute(userId: Int) -> Observable<[Badge]> {
        userRepository.fetchBadges(userID: userId)
    }

}
