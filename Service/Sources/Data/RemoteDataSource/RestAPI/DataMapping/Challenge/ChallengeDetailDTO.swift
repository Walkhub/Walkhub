import Foundation

// MARK: - Data Transfer Object
struct ChallengeDetailDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case content
        case userScope = "user_scope"
        case goal
        case goalScope = "goal_scope"
        case goalType = "goal_type"
        case award
        case imageUrlString = "image_url"
        case start = "start_at"
        case end = "end_at"
        case count = "participant_count"
        case isMine
        case isParticipated = "is_participated"
        case writer
    }
    let name: String
    let content: String
    let userScope: String
    let goal: Int
    let goalScope: String
    let goalType: String
    let award: String
    let imageUrlString: String
    let start: String
    let end: String
    let count: Int
    let isMine: Bool
    let isParticipated: Bool
    let writer: WriterDTO
}

// MARK: - Mappings to Domain
extension ChallengeDetailDTO {
    func toDomain() -> ChallengeDetail {
        return .init(
            name: name,
            content: content,
            userScope: userScope,
            goal: goal,
            goalScope: goalScope,
            goalType: goalType,
            award: award,
            imageUrl: URL(string: imageUrlString)!,
            start: start.toDateWithTime(),
            end: end.toDateWithTime(),
            count: count,
            isMine: isMine,
            isParticipated: isParticipated,
            writer: writer.toDomain()
        )
    }
}
