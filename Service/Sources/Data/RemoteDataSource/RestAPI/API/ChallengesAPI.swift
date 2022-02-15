import Foundation

import Moya

enum ChallengesAPI {
    case fetchChallengesList
    case fetchDetailChallenges(challengeID: Int)
    case joinChallenges(challengeID: Int)
    case fetchParticipantsChallengesList(challengeID: Int)
    case fetchJoingChallenges
}

extension ChallengesAPI: WalkhubAPI {
    var domain: ApiDomain {
        .challenges
    }

    var urlPath: String {
        switch self {
        case .fetchDetailChallenges(let challengeID), .joinChallenges(let challengeID):
            return "/\(challengeID)"
        case .fetchChallengesList:
            return "/lists"
        case .fetchParticipantsChallengesList(let challengeID):
            return "/\(challengeID)/participants/students"
        case .fetchJoingChallenges:
            return "/participated"
        }
    }

    var method: Moya.Method {
        switch self {
        case .joinChallenges:
            return .post
        case .fetchChallengesList, .fetchDetailChallenges, .fetchParticipantsChallengesList,
                .fetchJoingChallenges:
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
        case .fetchDetailChallenges:
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
        case .fetchJoingChallenges:
            return [
                401: .unauthorization
            ]
        }
    }
}
