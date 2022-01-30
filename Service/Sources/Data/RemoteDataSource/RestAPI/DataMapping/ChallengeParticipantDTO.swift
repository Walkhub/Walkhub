import Foundation

// MARK: - Data Transfer Object
struct ChallengeParticipantDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case gcn
        case profileImageUrlString = "profile_image_url"
    }
    let id: Int
    let name: String
    let gcn: String
    let profileImageUrlString: String
}

// MARK: - Mappings to Domain
extension ChallengeParticipantDTO {
    func toDomain() -> ChallengeParticipant {
        return .init(
            id: id,
            name: name,
            gcn: gcn,
            profileImageUrlString: URL(string: profileImageUrlString)!
        )
    }
}
