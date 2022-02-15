import Foundation

import RxSwift

public class FetchSchoolRankUseCase {

    private let rankRepository: RankRepository

    init(rankRepository: RankRepository) {
        self.rankRepository = rankRepository
    }

    public func excute(dateType: DateType) -> Observable<SchoolRank> {
        rankRepository.fetchSchoolRank(dateType: dateType)
    }

}
