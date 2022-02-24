import Foundation

// MARK: - Data Transfer Object
struct UserProfileDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name
        case profileImageUrlString = "profile_image_url"
        case school = "school_name"
        case grade
        case classNum
        case titleBadge = "title_badge"
        case level
    }
    let userID: Int
    let name: String
    let profileImageUrlString: String
    let school: String?
    let grade: Int?
    let classNum: Int?
    let titleBadge: BadgeDTO
    let level: LevelDTO
}

// MARK: - Mapppings to Domain
extension UserProfileDTO {
    func toDomain() -> UserProfile {
        return .init(
            userID: userID,
            name: name,
            profileImageUrl: URL(string: profileImageUrlString)!,
            school: school ?? "",
            grade: grade,
            classNum: classNum,
            titleBadge: titleBadge.toDomain(),
            level: level.toDomain()
        )
    }
}
