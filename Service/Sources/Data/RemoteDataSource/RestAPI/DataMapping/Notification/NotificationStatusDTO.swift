import Foundation

struct NotificationStatusDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case notice = "is_notice"
        case challenge = "is_challenge"
        case challengeSuccess = "is_challenge_success"
        case challengeExpiration = "is_challenge_expiration"
        case cheering = "is_cheering"
    }
    let notice: Bool
    let challenge: Bool
    let challengeSuccess: Bool
    let challengeExpiration: Bool
    let cheering: Bool
}

extension NotificationStatusDTO {
    func toDomain() -> NotificationStatus {
        return .init(
            notice: notice,
            challenge: challenge,
            challengeSuccess: challengeSuccess,
            challengeExpiration: challengeExpiration,
            cheering: cheering
        )
    }
}
