import Foundation

// MARK: - Data Transfer Object
struct ChallengeParticipantDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case name
        case profileImageUrlString = "profile_image_url"
    }
    let id: Int
    let name: String
    let profileImageUrlString: String
}

// MARK: - Mappings to Domain
extension ChallengeParticipantDTO {
    func toDomain() -> ChallengeParticipant {
        return .init(
            id: id,
            name: name,
            profileImageUrlString: URL(string: profileImageUrlString)!
        )
    }
}
