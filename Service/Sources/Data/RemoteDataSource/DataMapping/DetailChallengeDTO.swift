import Foundation

// MARK: - Data Transfer Object
struct DetailChallenge: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case content
        case goal
        case award
        case imageUrlString = "image_url"
        case start = "start_at"
        case end = "end_at"
        case scope
        case count = "participant_count"
        case isMine
        case writer
    }
    let name: String
    let content: String
    let goal: Int
    let award: String
    let imageUrlString: String
    let start: String
    let end: String
    let scope: String
    let count: Int
    let isMine: Bool
    let writer: WriterDTO
}
