import Foundation

struct UserListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case userList = "user_list"
    }
    let userList: [UserInformation]
}

extension UserListDTO {
    struct UserInformation: Decodable {
        private enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case name
            case rank
            case profileImageUrlString = "profile_image_url"
            case walkCount = "walk_count"
        }
        let userID: Int
        let name: String
        let rank: Int
        let profileImageUrlString: String
        let walkCount: Int
    }
}
