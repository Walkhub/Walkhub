import Foundation

import RxSwift

public class FetchProfileUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute() -> Observable<UserProfile> {
        return userRepository.fetchMyProfile()
    }
}
