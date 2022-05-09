import Foundation

// MARK: - Data Transfer Object
struct NotificationDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case type
        case data
        case writer
        case created = "created_at"
        case isRead = "is_read"
    }
    let id: Int
    let title: String
    let content: String
    let type: String
    let data: String
    let writer: WriterDTO
    let created: String
    let isRead: Bool
}

// MARK: - Mappings to Domain
extension NotificationDTO {
    func toDomain() -> NotificationData {
        return .init(
            id: id,
            title: title,
            content: content,
            type: NotificationType(rawValue: type) ?? .notification,
            data: data,
            writer: writer.toDomain(),
            created: created.toDateWithTime(),
            isRead: isRead
        )
    }
}
