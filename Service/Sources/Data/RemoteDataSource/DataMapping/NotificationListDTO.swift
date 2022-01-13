import Foundation

struct NotificationListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case notificationList: "notification_list"
    }
}

extension NotificationListDTO {
    struct Notification: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case title
            case content
            case type
            case value
            case read = "is_read"
        }
        let id: Int
        let title: String
        let content: String
        let type: String
        let value: Int
        let read: Bool
    }
}