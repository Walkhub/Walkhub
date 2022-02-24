import Foundation

// MARK: - Data Transfer Object
struct ChallengeDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case start = "start_at"
        case end = "end_at"
        case imageUrlString = "image_url"
        case userScope = "user_scope"
        case goalScope = "goal_scope"
        case goalType = "goal_type"
        case writer
    }
    let id: Int
    let name: String
    let start: String
    let end: String
    let imageUrlString: String?
    let userScope: String
    let goalScope: String
    let goalType: String
    let writer: WriterDTO
}

// MARK: - Mappings to Domain
extension ChallengeDTO {
    func toDomain() -> Challenge {
        return .init(
            id: id,
            name: name,
            start: start.toDateWithTime(),
            end: end.toDateWithTime(),
            imageUrl: URL(string: imageUrlString ?? ""),
            userScope: GroupScope(rawValue: userScope)!,
            goalScope: ChallengeGoalScope(rawValue: goalScope)!,
            goalType: ExerciseGoalType(rawValue: goalType)!,
            writer: writer.toDomain()
        )
    }
}
