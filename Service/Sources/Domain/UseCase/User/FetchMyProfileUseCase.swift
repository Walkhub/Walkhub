import Foundation

import RxSwift

class FetchMyProfileUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func excute() -> Observable<UserProfile> {
        userRepository.fetchMyProfile()
    }

}
