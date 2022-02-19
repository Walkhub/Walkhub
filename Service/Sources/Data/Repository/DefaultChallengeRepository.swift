import Foundation

import RxSwift

//class DefaultChallengeRepository: ChallengeRepository {
//
//    private let remoteChallengesDataSource = RemoteChallengesDataSource.shared
//    private let localChallengeDataSource = LocalChallengeDataSource.shared
//
//    func fetchChallengesList() -> Single<[Challenge]> {
//        <#code#>
//    }
//
//    func fetchChallengeDetail(challengeId: Int) -> Single<ChallengeDetail> {
//        <#code#>
//    }
//
//    func joinChallenges(challengeId: Int) -> Single<Void> {
//        remoteChallengesDataSource.joinChallenges(challengeId: challengeId)
//    }
//
//    func fetchParticipantsChallengesList(challengeId: Int) -> Single<ChallengeParticipantList> {
//        <#code#>
//    }
//
//    func fetchJoingChallenges() -> Single<[Challenge]> {
//        <#code#>
//    }
//
//}
