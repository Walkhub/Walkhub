import Foundation

// MARK: - Data Transfer Object
struct UserListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case userList = "user_list"
    }
    let userList: [UserDTO]
}

// MARK: - Mappings to Domain
extension UserListDTO {
    func toDomain() -> [User] {
        return userList.map { $0.toDomain() }
    }
}
