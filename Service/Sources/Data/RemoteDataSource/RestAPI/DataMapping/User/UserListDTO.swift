import Foundation

// MARK: - Data Transfer Object
struct UserListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "user_list"
    }
    let list: [UserDTO]
}

// MARK: - Mappings to Domain
extension UserListDTO {
    func toDomain() -> [User] {
        return list.map { $0.toDomain() }
    }
}
