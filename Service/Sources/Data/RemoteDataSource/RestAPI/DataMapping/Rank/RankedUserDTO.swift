import Foundation

struct RankedUserDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case ranking
        case profileImageUrlString = "profile_image_url"
        case walkCount = "walk_count"
    }
    let userId: Int
    let name: String
    let ranking: Int
    let profileImageUrlString: String
    let walkCount: Int
}

extension RankedUserDTO {
    func toDomain() -> RankedUser {
        return .init(
            userId: userId,
            name: name,
            ranking: ranking,
            profileImageUrl: URL(string: profileImageUrlString)!,
            walkCount: walkCount
        )
    }
}
