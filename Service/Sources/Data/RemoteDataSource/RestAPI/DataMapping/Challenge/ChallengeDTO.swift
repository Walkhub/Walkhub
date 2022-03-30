import Foundation

// MARK: - Data Transfer Object
struct ChallengeDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case start = "start_at"
        case end = "end_at"
        case goal
        case goalScope = "goal_scope"
        case goalType = "goal_type"
        case award
        case writer
        case participantCount = "participant_count"
        case participantList = "participant_list"
    }
    let id: Int
    let name: String
    let start: String
    let end: String
    let goal: Int
    let goalScope: String
    let goalType: String
    let award: String
    let writer: WriterDTO
    let participantCount: Int
    let participantList: [ChallengeParticipantDTO]
}

// MARK: - Mappings to Domain
extension ChallengeDTO {
    func toDomain() -> Challenge {
        return .init(
            id: id,
            name: name,
            start: start.toDate(),
            end: end.toDate(),
            goal: goal,
            goalScope: ChallengeGoalScope(rawValue: goalScope)!,
            goalType: ExerciseGoalType(rawValue: goalType)!,
            award: award,
            writer: writer.toDomain(),
            participantCount: participantCount,
            participantList: participantList.map { $0.toDomain() }
        )
    }
}
