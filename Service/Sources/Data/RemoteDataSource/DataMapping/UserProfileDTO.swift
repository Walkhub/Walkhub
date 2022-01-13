import Foundation

struct UserProfileDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case profileImageString = "profile_image_url"
        case school = "school_name"
        case grade
        case classNum
        case titleBadge = "title_badge"
    }
    let name: String
    let profileImageString: String
    let school: String
    let grade: Int
    let classNum: Int
    let titleBadge: TitleBadge
}

extension UserProfileDTO {
    struct TitleBadge: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case imageString = "image_url"
        }
        let id: Int
        let name: String
        let imageString: String
    }
}
