import Foundation

struct NotificationStatusDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case topicId = "topic_id"
        case title
        case isSubscribe = "is_subscribe"
    }
    let topicId: Int
    let title: String
    let isSubscribe: Bool
}

extension NotificationStatusDTO {
    func toDomain() -> NotificationStatus {
        return .init(
            topicId: topicId,
            title: NotificationType(rawValue: title)!,
            isSubscribe: isSubscribe
        )
    }
}
