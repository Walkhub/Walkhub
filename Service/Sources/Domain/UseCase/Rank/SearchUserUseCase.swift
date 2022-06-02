import Foundation

import RxSwift

public class SearchUserUseCase {

    private let rankRepository: RankRepository

    init(rankRepository: RankRepository) {
        self.rankRepository = rankRepository
    }

    public func excute(
        name: String,
        dateType: DateType,
        schoolId: Int
    ) -> Observable<[User]> {
        return rankRepository.searchUser(
            name: name,
            dateType: dateType,
            schoolId: schoolId
        )
    }
}
