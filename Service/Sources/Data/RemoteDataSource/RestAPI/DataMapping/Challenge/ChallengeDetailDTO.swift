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
        case successStandard = "success_standard"
        case count = "participant_count"
        case isMine = "is_mine"
        case isParticipated = "is_participated"
        case participantList = "participant_list"
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
    let successStandard: Int
    let count: Int
    let isMine: Bool
    let isParticipated: Bool
    let participantList: [ChallengeParticipantDTO]
    let writer: WriterDTO
}

// MARK: - Mappings to Domain
extension ChallengeDetailDTO {
    func toDomain() -> ChallengeDetail {
        return .init(
            name: self.name,
            content: self.content,
            userScope: self.userScope,
            goal: self.goal,
            goalScope: self.goalScope,
            goalType: self.goalType,
            award: self.award,
            imageUrl: URL(string: self.imageUrlString)!,
            start: self.start.toDate(),
            end: self.end.toDate(),
            successStandard: self.successStandard,
            count: self.count,
            isMine: self.isMine,
            isParticipated: self.isParticipated,
            participantList: self.participantList.map { $0.toDomain() },
            writer: self.writer.toDomain()
        )
    }
}
