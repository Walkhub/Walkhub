import Foundation

// MARK: - Data Transfer Object
struct NotificationListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case notificationList = "notification_list"
    }
    let notificationList: [NotificationDTO]
}
