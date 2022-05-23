import Foundation

import RxSwift

public class FetchAnotherSchoolUserRankUseCase {

    private let rankRepository: RankRepository

    init(rankRepository: RankRepository) {
        self.rankRepository = rankRepository
    }

    public func excute(
        schoolId: Int,
        dateType: DateType
    ) -> Observable<[RankedUser]> {
        return rankRepository.fetchAnotherSchoolUserRank(
            schoolId: schoolId,
            dateType: dateType
        )
    }
}
