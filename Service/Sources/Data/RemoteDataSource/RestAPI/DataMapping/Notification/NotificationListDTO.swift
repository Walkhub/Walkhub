import Foundation

// MARK: - Data Transfer Object
struct NotificationListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "notification_list"
    }
    let list: [NotificationDTO]
}

// MARK: - Mappings to Domain
extension NotificationListDTO {
    func toDomain() -> [Notification] {
        return list.map { $0.toDomain() }
    }
}
