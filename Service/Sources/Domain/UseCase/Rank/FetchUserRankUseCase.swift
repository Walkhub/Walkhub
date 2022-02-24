import Foundation

import RxSwift

public class FetchUserRankUseCase {

    private let rankRepository: RankRepository

    init(rankRepository: RankRepository) {
        self.rankRepository = rankRepository
    }

    public func excute(
        schoolId: Int,
        dateType: DateType
    ) -> Single<[DefaultSchoolUserRank]> {
        return rankRepository.fetchUserRank(
            schoolId: schoolId,
            dateType: dateType
        )
    }
}
