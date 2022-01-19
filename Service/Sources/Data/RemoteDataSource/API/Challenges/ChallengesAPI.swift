import Foundation

import Moya

enum ChallengesAPI {
    case viewChallengesList
    case viewDetailChallenges(challengeID: Int)
    case participationChallenges(challengeID: Int)
    case viewParticipantsChallengesList(challengeID: Int)
}

extension ChallengesAPI: WalkhubAPI {
    var domain: ApiDomain {
        .challenges
    }
    
    var urlPath: String {
        switch self {
        case .viewDetailChallenges(let challengeID), .participationChallenges(let challengeID):
            return "/\(challengeID)"
        case .viewChallengesList:
            return "/lists"
        case .viewParticipantsChallengesList(let challengeID):
            return "/\(challengeID)/participants"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .participationChallenges:
            return .post
        case .viewChallengesList, .viewDetailChallenges, .viewParticipantsChallengesList:
            return .get
        }
    }
    
    var jwtTokenType: JWTTokenType? {
        return .accessToken
    }
}
