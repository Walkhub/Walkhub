import Foundation

// MARK: - Data Transfer Object
struct SchoolDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case schoolId = "school_id"
        case name
        case ranking
        case logoImageUrlString = "logo_image_url"
        case walkCount = "walk_count"
        case userCount = "user_count"
    }
    let schoolId: Int
    let name: String
    let ranking: Int
    let logoImageUrlString: String
    let walkCount: Int
    let userCount: Int
}

// MARK: - Mappings to Domain
extension SchoolDTO {
    func toDomain() -> School {
        return .init(
            schoolId: schoolId,
            name: name,
            ranking: ranking,
            logoImageUrl: URL(string: logoImageUrlString)!,
            walkCount: walkCount,
            userCount: userCount
        )
    }
}
