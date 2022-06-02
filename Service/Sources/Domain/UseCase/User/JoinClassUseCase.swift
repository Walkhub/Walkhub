import Foundation

import RxSwift

public class JoinClassUseCase {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(
        _ classCode: String,
        _ number: Int
    ) -> Completable {
        return userRepository.joinClass(
            classCode: classCode,
            num: number
        )
    }
}
