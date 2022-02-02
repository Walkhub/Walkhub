import Foundation

// MARK: - Data Transfer Object
struct ChallengeDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case start = "start_at"
        case end = "end_at"
        case imageUrlString = "image_url"
        case scope
    }
    let id: Int
    let name: String
    let start: String
    let end: String
    let imageUrlString: String
    let scope: String
}

// MARK: - Mappings to Domain
extension ChallengeDTO {
    func toDomain() -> Challenge {
        return .init(
            id: id,
            name: name,
            start: start.toDate(),
            end: end.toDate(),
            imageUrl: URL(string: imageUrlString)!,
            scope: scope
        )
    }
}
