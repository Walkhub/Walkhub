import Foundation

import RxSwift

public class FetchSchoolRankUseCase {

    private let rankRepository: RankRepository

    init(rankRepository: RankRepository) {
        self.rankRepository = rankRepository
    }

    public func excute() -> Observable<MySchool> {
        rankRepository.fetchSchoolRank()
    }

}
