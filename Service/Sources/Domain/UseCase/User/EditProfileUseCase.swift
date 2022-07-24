import Foundation

import RxSwift

public class EditProfileUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(
        name: String,
        profileImageUrlString: String,
        schoolId: Int
    ) -> Completable {
        return userRepository.changeProfile(
            name: name,
            profileImageUrlString: profileImageUrlString,
            schoolId: schoolId
        )
    }
}
 
