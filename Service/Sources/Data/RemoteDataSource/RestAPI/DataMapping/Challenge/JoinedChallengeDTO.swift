import Foundation

struct JoinedChallengeDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrlString = "image_url"
        case start = "start_at"
        case end = "end_at"
        case goal
        case goalScope = "goal_scope"
        case goalType = "goal_type"
        case totalValue = "total_value"
        case writer
    }
    let id: Int
    let name: String
    let imageUrlString: String
    let start: String
    let end: String
    let goal: Int
    let goalScope: String
    let goalType: String
    let totalValue: Int?
    let writer: WriterDTO
}

extension JoinedChallengeDTO {
    func toDoman() -> JoinedChallenge {
        return .init(
            id: id,
            name: name,
            imageUrl: URL(string: imageUrlString)!,
            start: start.toDate(),
            end: end.toDate(),
            goal: goal,
            goalScope: ChallengeGoalScope(rawValue: goalScope) ?? .all,
            goalType: ExerciseGoalType(rawValue: goalType) ?? .distance,
            totalValue: totalValue ?? 0,
            writer: writer.toDomain()
        )
    }
}
