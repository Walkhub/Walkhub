import Foundation

struct UserListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case userList = "user_list"
    }
    let userList: [UserDTO]
}


struct UserDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name
        case rank
        case grade
        case classNum = "class_num"
        case profileImageUrlString = "profile_image_url"
        case walkCount = "walk_count"
    }
    let userID: Int
    let name: String
    let rank: Int
    let grade: Int
    let classNum: Int
    let profileImageUrlString: String
    let walkCount: Int
}
