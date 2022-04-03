import Foundation

import RxSwift

public class SetHealthInformationUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(
        height: Float,
        weight: Int,
        sex: Sex
    ) -> Completable {
        return userRepository.setHealthInformation(
            height: height,
            weight: weight,
            sex: sex
        )
    }
}
