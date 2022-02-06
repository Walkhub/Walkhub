import Foundation

struct Notification: Equatable {
    let id: Int
    let title: String
    let content: String
    let type: NotificationType
    let value: Int
    let isRead: Bool
}
