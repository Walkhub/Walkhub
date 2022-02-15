import Foundation

struct MyBadgeDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrlString = "image_url"
        case isMine = "is_mine"
    }
    let id: Int
    let name: String
    let imageUrlString: String
    let isMine: Bool
}
