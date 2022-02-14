import Foundation

struct LevelDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case imageUrlString = "image_url"
    }
    let name: String
    let imageUrlString: String
}
