import Foundation

// MARK: - Data Transfer Object
struct NoticeDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case createdAt = "created_at"
        case writer
    }
    let id: Int
    let title: String
    let content: String
    let createdAt: String
    let writer: WriterDTO
}

// MARK: - Mappings to Domain
extension NoticeDTO {
    func toDomain() -> Notice {
        return .init(
            id: id,
            title: title,
            content: content,
            createdAt: createdAt.toDate(),
            writer: writer.toDomain()
        )
    }
}
