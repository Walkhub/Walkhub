import Foundation

import RxSwift

public class FetchUserProfileUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(userId: Int) -> Observable<UserProfile> {
        userRepository.fetchProfile(userID: userId)
    }

}
