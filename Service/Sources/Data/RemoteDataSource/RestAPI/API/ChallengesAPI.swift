import Foundation

import Moya

enum ChallengesAPI {
    case fetchChallengesList
    case fetchChallengeDetail(challengeId: Int)
    case joinChallenges(challengeId: Int)
    case fetchParticipantsChallengesList(challengeId: Int)
    case fetchJoinedChallenges
    case fetchEndChallengeList
}

extension ChallengesAPI: WalkhubAPI {
    var domain: ApiDomain {
        .challenges
    }

    var urlPath: String {
        switch self {
        case .joinChallenges(let challengeId):
            return "/\(challengeId)"
        case .fetchChallengesList:
            return "/app/lists"
        case .fetchParticipantsChallengesList(let challengeId):
            return "/\(challengeId)/participants/students"
        case .fetchJoinedChallenges:
            return "/participated"
        case .fetchEndChallengeList:
            return "/docs/template"
        case .fetchChallengeDetail(let challengeId):
            return "/app/\(challengeId)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .joinChallenges:
            return .post
        case .fetchChallengesList, .fetchChallengeDetail, .fetchParticipantsChallengesList,
                .fetchJoinedChallenges, .fetchEndChallengeList:
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
        case .fetchEndChallengeList:
            return [
                401: .unauthorization
            ]
        }
    }
}
