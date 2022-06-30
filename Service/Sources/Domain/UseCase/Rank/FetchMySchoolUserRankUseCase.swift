import Foundation

import RxSwift

public class FetchMySchoolUserRankUseCase {
    private let rankRepository: RankRepository

    init(rankRepository: RankRepository) {
        self.rankRepository = rankRepository
    }

    public func excute(
        scope: GroupScope,
        dateType: DateType
    ) -> Observable<(UserRank, Int?)> {
        return rankRepository.fetchMySchoolUserRank(
            scope: scope,
            dateType: dateType
        ).map { data in
            return (data, data.rankList.last {
                $0.ranking > data.myRank.ranking
            }?.walkCount)
        }
    }
}
