import Foundation

// MARK: - Data Transfer Object
struct ImageUrlDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "image_url"
    }
    let list: [String]
}

// MARK: - Mappings to Domain
extension ImageUrlDTO {
    func toDomain() -> [URL] {
        return list.map { URL(string: $0)! }
    }
}
