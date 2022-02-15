import Foundation

// MARK: - Data Transfer Object
struct ChallengeParticipantListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case count = "challenge_participants_count"
        case list = "challenge_participants_list"
    }
    let count: Int
    let list: [ChallengeParticipantDTO]
}

// MARK: - Mappings to Domain
extension ChallengeParticipantListDTO {
    func toDomain() -> ChallengeParticipantList {
        return .init(
            count: count,
            list: list.map { $0.toDomain() }
        )
    }
}
