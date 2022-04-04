import Foundation

// MARK: - Data Transfer Object
struct ExerciseAnalysisDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case walkCountList = "walk_count_list"
        case dailyWalkCountGoal = "daily_walk_count_goal"
        case walkCount = "walk_count"
        case calorie
        case distance
    }
    let walkCountList: [Int]
    let dailyWalkCountGoal: Int
    let walkCount: Int?
    let calorie: Double?
    let distance: Int?
}

// MARK: - Mappings to Domain
extension ExerciseAnalysisDTO {
    func toDomain() -> ExerciseAnalysis {
        return .init(
            walkCountList: walkCountList,
            dailyWalkCountGoal: dailyWalkCountGoal,
            walkCount: walkCount ?? 0,
            calorie: calorie ?? 0,
            distance: distance ?? 0
        )
    }
}
