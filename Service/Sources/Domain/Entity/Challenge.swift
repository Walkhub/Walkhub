import Foundation

public struct Challenge: Equatable {
    public let id: Int
    public let name: String
    public let imageUrl: URL
    public let start: Date
    public let end: Date
    public let goal: Int
    public let goalScope: ChallengeGoalScope
    public let goalType: ExerciseGoalType
    public let award: String
    public let writer: Writer
    public let participantCount: Int
    public let participantList: [ChallengeParticipant]
}
