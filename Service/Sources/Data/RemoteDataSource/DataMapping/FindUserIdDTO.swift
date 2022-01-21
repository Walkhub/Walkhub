import Foundation

// MARK: - Data Transfer Object
struct FindUserIdDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case userID = "account_id"
    }
    let userID: String
}
