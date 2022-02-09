import Foundation

import RxSwift

public class PatchHealthUseCase {

    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute(height: Float, weight: Int) -> Single<Void> {
        userRepository.patchHealth(height: height, weight: weight)
    }

}
