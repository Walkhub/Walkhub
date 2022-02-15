import Foundation

import RxSwift

public class JoinClassUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(groupId: Int) -> Completable {
        userRepository.joinClass(groupId: groupId)
    }

}
