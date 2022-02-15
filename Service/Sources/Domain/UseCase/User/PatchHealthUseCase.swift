import Foundation

import RxSwift

public class PatchHealthUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(height: Float, weight: Int) -> Completable {
        userRepository.patchHealthInformation(height: height, weight: weight)
    }

}
