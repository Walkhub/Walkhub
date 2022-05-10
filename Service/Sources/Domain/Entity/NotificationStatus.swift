import Foundation

public struct NotificationStatus: Equatable {
    public let notice: Bool
    public let challenge: Bool
    public let challengeSuccess: Bool
    public let challengeExpiration: Bool
    public let cheering: Bool
}
