import Foundation

// MARK: - Data Transfer Object
struct BadgeDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "badge_id"
        case name
        case imageUrlString = "image_url"
    }
    let id: Int
    let name: String
    let imageUrlString: String
}

// MARK: - Mappings to Domain
extension BadgeDTO {
    func toDomain() -> Badge {
        return .init(
            id: id,
            name: name,
            imageUrl: URL(string: imageUrlString)!
        )
    }
}
