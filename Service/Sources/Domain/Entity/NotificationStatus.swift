import Foundation

public struct NotificationStatus: Equatable {
    public let topicId: Int
    public let title: NotificationType
    public let isSubscribe: Bool
}
