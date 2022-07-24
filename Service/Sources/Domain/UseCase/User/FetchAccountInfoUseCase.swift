import Foundation

import RxSwift

public class FetchAccountInfoUseCase {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    public func excute() -> Observable<AccountInfo> {
        return self.userRepository.fetchAccountInfo()
    }
}
