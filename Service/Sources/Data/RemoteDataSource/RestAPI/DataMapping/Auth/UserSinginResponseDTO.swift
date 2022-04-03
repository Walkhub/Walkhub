import Foundation

// MARK: - Data Transfer Object
struct UserSinginResponseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiredAt = "expired_at"
        case refreshToken = "refresh_token"
        case authority
        case height
        case weight
        case sex
    }
    let accessToken: String
    let expiredAt: String
    let refreshToken: String
    let authority: String
    let height: Double?
    let weight: Int?
    let sex: String
}
