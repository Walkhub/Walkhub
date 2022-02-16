import Foundation

import RxSwift

public class SearchUserUseCase {

    private let rankRepository: RankRepository

    init(rankRepository: RankRepository) {
        self.rankRepository = rankRepository
    }

    public func excute(
        schoolId: Int,
        name: String,
        dateType: DateType
    ) -> Single<[User]> {
        return rankRepository.searchUser(
            schoolId: schoolId,
            name: name,
            dateType: dateType
        )
    }
}
