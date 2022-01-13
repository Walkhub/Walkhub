import Foundation

struct FindUserIDDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case userID = "account_id"
    }
    let userID: String
}
