import Foundation

public struct Challenge: Equatable {
    public let id: Int
    public let name: String
    public let start: Date
    public let end: Date
    public let imageUrl: URL?
    public let userScope: GroupScope
    public let goalScope: ChallengeGoalScope
    public let goalType: ExerciseGoalType
    public let writer: Writer
}
