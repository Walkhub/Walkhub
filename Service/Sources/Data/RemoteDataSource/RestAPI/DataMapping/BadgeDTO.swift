import Foundation

// MARK: - Data Transfer Object
struct BadgeDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrlString = "image_url"
    }
    let id: Int
    let name: String
    let imageUrlString: String
}
