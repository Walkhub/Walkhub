import Foundation

import RxSwift

public class FetchUserSchoolRankUseCase {
    private let rankRepository: RankRepository

    init(rankRepository: RankRepository) {
        self.rankRepository = rankRepository
    }

    public func excute(
        scope: Scope,
        dateType: DateType
    ) -> Observable<(UserRank, Int?)> {
        return rankRepository.fetchUserSchoolRank(
            scope: scope,
            dateType: dateType
        ).map { data in
            return (data, data.rankList.last {
                $0.ranking > data.myRank.ranking
            }?.walkCount)
        }
    }
}
