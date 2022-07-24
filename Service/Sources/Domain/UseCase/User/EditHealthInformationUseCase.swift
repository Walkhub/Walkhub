import Foundation

import RxSwift

public class EditHealthInformationUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(
        height: Double?,
        weight: Int?,
        sex: Sex
    ) -> Completable {
        if weight == 0 {
            return userRepository.setHealthInformation(
                height: height,
                weight: nil,
                sex: sex
            )
        } else {
            return userRepository.setHealthInformation(
                height: height,
                weight: weight,
                sex: sex
            )
        }
    }
}
