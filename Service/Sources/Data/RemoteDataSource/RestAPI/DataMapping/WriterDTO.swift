import Foundation

// MARK: - Data Transfer Object
struct WriterDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case profileImageUrlString = "profile_image_url"
    }
    let id: Int
    let name: String
    let profileImageUrlString: String
}

// MARK: - Mappings to Domain
extension WriterDTO {
    func toDomain() -> Writer {
        return .init(
            id: id,
            name: name,
            profileImageUrl: URL(string: profileImageUrlString)!
        )
    }
}
