import Foundation

import RxSwift

public class SearchSchoolRankUseCase {

    private var rankRepository: RankRepository

    init(rankRepository: RankRepository) {
        self.rankRepository = rankRepository
    }

    public func excute(
        name: String,
        dateType: DateType
    ) -> Single<[SearchSchoolRank]> {
        return rankRepository.searchSchool(
            name: name,
            dateType: dateType
        )
    }
}
