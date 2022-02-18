import Foundation

// MARK: - Data Transfer Object
struct UserDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name
        case grade
        case classNum = "class_num"
        case ranking
        case profileImageUrlString = "profile_image_url"
        case walkCount = "walk_count"
    }
    let userID: Int
    let name: String
    let grade: Int
    let classNum: Int
    let ranking: Int
    let profileImageUrlString: String
    let walkCount: Int
}

// MARK: - Mappings to Domain
extension UserDTO {
    func toDomain() -> User {
        return .init(
            userID: userID,
            name: name,
            ranking: ranking,
            grade: grade,
            classNum: classNum,
            profileImageUrl: URL(string: profileImageUrlString)!,
            walkCount: walkCount
        )
    }
}
