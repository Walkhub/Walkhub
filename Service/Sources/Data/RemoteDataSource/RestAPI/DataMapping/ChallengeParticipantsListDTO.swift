import Foundation

// MARK: - Data Transfer Object
struct ChallengeParticipantListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "challenge_participants_list"
    }
    let list: [ChallengeParticipantDTO]
}

// MARK: - Mappings to Domain
extension ChallengeParticipantListDTO {
    func toDomain() -> [ChallengeParticipant] {
        return list.map { $0.toDomain() }
    }
}
