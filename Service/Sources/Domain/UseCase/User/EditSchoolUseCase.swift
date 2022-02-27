import Foundation

import RxSwift

public class EditSchoolUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(schoolId: Int) -> Completable {
        return userRepository.setSchoolInformation(schoolId: schoolId)
    }
}
