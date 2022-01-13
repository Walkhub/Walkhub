import Foundation

struct DetailNoticeDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case title
        case content
        case createdAt = "created_at"
        case isMine
        case writer
    }
    let title: String
    let content: String
    let createdAt: String
    let isMine: Bool
    let writer: Writer
}

extension DetailNoticeDTO {
    struct Writer: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case profileImageUrlString = "profile_image_url"
        }
        let id: Int
        let name: String
        let profileImageUrlString: String
    }
}
