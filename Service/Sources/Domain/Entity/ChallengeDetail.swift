import Foundation

public struct ChallengeDetail {
    public let name: String
    public let content: String
    public let goal: Int
    public let award: String
    public let imageUrl: URL
    public let start: Date
    public let end: Date
    public let scope: String
    public let count: Int
    public let isMine: Bool
    public let writer: Writer
}
