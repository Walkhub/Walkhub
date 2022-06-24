import Foundation

public struct ChallengeDetail: Equatable {
    public let name: String
    public let content: String
    public let userScope: String
    public let goal: Int
    public let goalScope: String
    public let goalType: String
    public let award: String
    public let imageUrl: URL
    public let start: Date
    public let end: Date
    public let successStandard: Int
    public let count: Int
    public let isMine: Bool
    public let isParticipated: Bool
    public let participantList: [ChallengeParticipant]
    public let writer: Writer
    public let profileImageUrl: URL
    public let totalValue: Int
}
