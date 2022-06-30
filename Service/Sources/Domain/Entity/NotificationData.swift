import Foundation

public struct NotificationData: Equatable {
    public let id: Int
    public let title: String
    public let content: String
    public let type: NotificationType
    public let data: String
    public let writer: Writer
    public let created: Date
    public let isRead: Bool
}
