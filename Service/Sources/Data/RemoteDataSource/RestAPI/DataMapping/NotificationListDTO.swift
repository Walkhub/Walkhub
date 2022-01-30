import Foundation

// MARK: - Data Transfer Object
struct NotificationListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case notificationList = "notification_list"
    }
    let notificationList: [NotificationDTO]
}

// MARK: - Mappings to Domain
extension NotificationListDTO {
    func toDomain() -> [Notification] {
        return notificationList.map { $0.toDomain() }
    }
}
