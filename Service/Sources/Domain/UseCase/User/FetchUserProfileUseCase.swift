import Foundation

import RxSwift

class FetchUserProfileUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(userId: Int) -> Observable<UserProfile> {
        userRepository.fetchProfile(userID: userId)
    }

}
