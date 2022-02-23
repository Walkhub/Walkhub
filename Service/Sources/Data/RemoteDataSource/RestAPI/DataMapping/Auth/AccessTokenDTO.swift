import Foundation

// MARK: - Data Transfer Object
struct AccessTokenDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiredAt = "expired_at"
    }
    let accessToken: String
    let expiredAt: String
}
