import Foundation

// MARK: - Data Transfer Object
struct ChallengeParticipantDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case profileImageUrlString = "profile_image_url"
    }
    let userId: Int
    let name: String
    let profileImageUrlString: String
}

// MARK: - Mappings to Domain
extension ChallengeParticipantDTO {
    func toDomain() -> ChallengeParticipant {
        return .init(
            id: userId,
            name: name,
            profileImageUrl: URL(string: profileImageUrlString)!
        )
    }
}
