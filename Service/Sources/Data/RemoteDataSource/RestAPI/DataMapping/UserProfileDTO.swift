import Foundation

// MARK: - Data Transfer Object
struct UserProfileDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case profileImageUrlString = "profile_image_url"
        case school = "school_name"
        case grade
        case classNum
        case titleBadge = "title_badge"
    }
    let name: String
    let profileImageUrlString: String?
    let school: String?
    let grade: Int?
    let classNum: Int?
    let titleBadge: BadgeDTO
}
