import Foundation

import RxSwift

public class FetchRankPreviewUseCase {

    private let rankRepository: RankRepository

    init(rankRepository: RankRepository) {
        self.rankRepository = rankRepository
    }

    public func excute() -> Observable<[RankedUser]> {
        rankRepository.fetchMySchoolUserRank(scope: .school, dateType: .day)
            .map { $0.rankList[0..<$0.rankList.count] }
            .map { Array($0) }
    }
}
