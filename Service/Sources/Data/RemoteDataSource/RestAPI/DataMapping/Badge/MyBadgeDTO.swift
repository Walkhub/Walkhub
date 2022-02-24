import Foundation

struct MyBadgeDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "badge_id"
        case name
        case imageUrlString = "image_url"
        case isMine = "is_mine"
    }
    let id: Int
    let name: String
    let imageUrlString: String
    let isMine: Bool
}

extension MyBadgeDTO {
    func toDomain() -> MyBadge {
        return .init(
            id: id,
            name: name,
            imageUrlString: URL(string: imageUrlString)!,
            isMine: isMine
        )
    }
}
