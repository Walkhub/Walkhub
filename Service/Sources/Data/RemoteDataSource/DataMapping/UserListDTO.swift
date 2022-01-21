import Foundation

struct UserListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case userList = "user_list"
    }
    let userList: [UserDTO]
}
