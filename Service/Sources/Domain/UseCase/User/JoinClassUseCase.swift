import Foundation

import RxSwift

public class JoinClassUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(classCode: String, number: Int) -> Completable {
        userRepository.joinClass(classCode: classCode, number: number)
    }

}
