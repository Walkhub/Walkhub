import Foundation

public struct ExerciseAnalysis: Equatable {
    public let walkCountList: [Int]
    public let dailyWalkCountGoal: Int
    public let walkCount: Int
    public let calorie: Double
    public let distane: Int
}

extension ExerciseAnalysis {
    public func excute() -> ExerciseAnalysisRemotePart {
        return .init(
            walkCountList: walkCountList,
            dailyWalkCountGoal: dailyWalkCountGoal
        )
    }
}
