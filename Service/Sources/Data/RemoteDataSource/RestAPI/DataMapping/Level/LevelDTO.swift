import Foundation

struct LevelDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case imageUrlString = "image_url"
    }
    let name: String
    let imageUrlString: String
}

extension LevelDTO {
    func toDomain() -> Level {
        return .init(
            name: name,
            imageUrlString: URL(string: imageUrlString)!
            )
    }
}
