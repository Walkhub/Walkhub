import Foundation

// MARK: - Data Transfer Object
struct NotificationDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case type
        case value
        case isRead = "is_read"
    }
    let id: Int
    let title: String
    let content: String
    let type: String
    let value: Int
    let isRead: Bool
}

// MARK: - Mappings to Domain
extension NotificationDTO {
    func toDomain() -> Notification {
        return .init(
            id: id,
            title: title,
            content: content,
            type: NotificationType(rawValue: type)!,
            value: value,
            isRead: isRead
        )
    }
}
