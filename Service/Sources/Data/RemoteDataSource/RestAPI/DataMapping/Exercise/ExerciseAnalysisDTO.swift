import Foundation

// MARK: - Data Transfer Object
struct ExerciseAnalysisDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case walkCountList = "walk_count_list"
        case dailyWalkCountGoal = "dailyWalkCountGoal"
        case walkCount = "walk_count"
        case calorie
        case distane
        case walkTime = "walk_time"
    }
    let walkCountList: [Int]
    let dailyWalkCountGoal: Int
    let walkCount: Int
    let calorie: Double
    let distane: Double
    let walkTime: Double
}

// MARK: - Mappings to Domain
extension ExerciseAnalysisDTO {
    func toDomain() -> ExerciseAnalysis {
        return .init(
            walkCountList: walkCountList,
            dailyWalkCountGoal: dailyWalkCountGoal,
            walkCount: walkCount,
            calorie: calorie,
            distane: distane,
            walkTime: walkTime
        )
    }
}
