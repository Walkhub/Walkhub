import Foundation

import Moya

enum ChallengesAPI {
    case fetchChallengesList
    case fetchChallengeDetail(challengeID: Int)
    case joinChallenges(challengeID: Int)
    case fetchParticipantsChallengesList(challengeID: Int)
    case fetchJoinedChallenges
}

extension ChallengesAPI: WalkhubAPI {
    var domain: ApiDomain {
        .challenges
    }

    var urlPath: String {
        switch self {
        case .fetchChallengeDetail(let challengeID), .joinChallenges(let challengeID):
            return "/\(challengeID)"
        case .fetchChallengesList:
            return "/lists"
        case .fetchParticipantsChallengesList(let challengeID):
            return "/\(challengeID)/participants/students"
        case .fetchJoinedChallenges:
            return "/participated"
        }
    }

    var method: Moya.Method {
        switch self {
        case .joinChallenges:
            return .post
        case .fetchChallengesList, .fetchChallengeDetail, .fetchParticipantsChallengesList,
                .fetchJoinedChallenges:
            return .get
        }
    }

    var jwtTokenType: JWTTokenType? {
        return .accessToken
    }

    var errorMapper: [Int: WalkhubError]? {
        switch self {
        case .fetchChallengesList:
            return [
                401: .unauthorization,
                403: .inaccessibleChallenge
            ]
        case .fetchChallengeDetail:
            return [
                401: .unauthorization,
                403: .inaccessibleChallenge,
                404: .undefinededChallenge
            ]
        case .joinChallenges:
            return [
                401: .unauthorization,
                404: .undefinededChallenge,
                409: .alreadyJoinedChallenge
            ]
        case .fetchParticipantsChallengesList:
            return [
                401: .unauthorization,
                403: .inaccessibleChallenge,
                404: .undefinededChallenge
            ]
        case .fetchJoinedChallenges:
            return [
                401: .unauthorization
            ]
        }
    }
}
