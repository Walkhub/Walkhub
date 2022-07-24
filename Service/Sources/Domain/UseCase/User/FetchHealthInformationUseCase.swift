import Foundation

import RxSwift

public class FetchHealthInformationUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute() -> Single<UserHealth> {
        return userRepository.fetchUserHealth()
    }
}
