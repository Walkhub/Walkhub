import Foundation

public struct Notification: Equatable {
    public let id: Int
    public let title: String
    public let content: String
    public let type: NotificationType
    public let value: Int
    public let isRead: Bool
}
