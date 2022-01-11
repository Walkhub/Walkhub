import Foundation

// MARK: - Data Transfer Object
struct TokenDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiredAt = "expired_at"
        case refreshToken = "refresh_token"
    }
    let accessToken: String
    let expiredAt: String
    let refreshToken: String
}
