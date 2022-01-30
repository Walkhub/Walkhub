import Foundation

// MARK: - Data Transfer Object
struct ChallengeListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case challengeList = "challenge_list"
    }
    let challengeList: [ChallengeDTO]
}

// MARK: - Mappings to Domain
extension ChallengeListDTO {
    func toDomain() -> [Challenge] {
        return challengeList.map { $0.toDomain() }
    }
}
