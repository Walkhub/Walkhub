import Foundation

// MARK: - Data Transfer Object
struct UserProfileDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name
        case profileImageUrlString = "profile_image_url"
        case school = "school_name"
        case schoolId = "school_id"
        case schoolImageUrlString = "school_image_url"
        case grade
        case classNum = "class_num"
        case titleBadge = "title_badge"
        case level
    }
    let userID: Int
    let name: String
    let profileImageUrlString: String
    let school: String
    let schoolId: Int
    let schoolImageUrlString: String
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
            school: school,
            schoolId: schoolId,
            schoolImageUrl: URL(string: schoolImageUrlString)!,
            grade: grade ?? 0,
            classNum: classNum ?? 0,
            titleBadge: titleBadge.toDomain(),
            level: level.toDomain()
        )
    }
}
