import Foundation

struct UserProfileDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case profileImg = "profile_image_url"
        case school = "school_name"
        case grade
        case classNum
        case titleBadge = "title_badge"
    }
    let name: String
    let profileImg: String
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
            case image = "image_url"
        }
        let id: Int
        let name: String
        let image: String
    }
}
