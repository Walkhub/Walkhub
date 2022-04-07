import Foundation

import RxSwift

public class FetchMyPageUseCase {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute() -> Observable<UserProfile> {
        return userRepository.fetchMyProfile()
    }
}
