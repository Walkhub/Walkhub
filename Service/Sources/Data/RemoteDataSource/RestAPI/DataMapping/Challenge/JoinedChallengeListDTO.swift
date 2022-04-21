import Foundation

struct JoinedChallengeListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case challengeList = "challenge_list"
    }
    let challengeList: [JoinedChallengeDTO]
}

extension JoinedChallengeListDTO {
    func toDomain() -> [JoinedChallenge] {
        return challengeList.map { $0.toDoman() }
    }
}
