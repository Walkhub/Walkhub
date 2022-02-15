import Foundation

// MARK: - Data Transfer Object
struct UserIdDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case userID = "account_id"
    }
    let userID: String
}

// MARK: - Mappings to Domain
extension UserIdDTO {
    func toDomain() -> String {
        return userID
    }
}
