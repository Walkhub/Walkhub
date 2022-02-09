import Foundation

// MARK: - Data Transfer Object
struct SchoolDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case schoolId = "school_id"
        case name
        case rank
        case logoImageUrlString = "logo_image_url"
        case walkCount = "walk_count"
    }
    let schoolId: String
    let name: String
    let rank: Int
    let logoImageUrlString: String
    let walkCount: Int
}

// MARK: - Mappings to Domain
extension SchoolDTO {
    func toDomain() -> School {
        return .init(
            schoolId: schoolId,
            name: name,
            rank: rank,
            logoImageUrl: URL(string: logoImageUrlString)!,
            walkCount: walkCount
        )
    }
}
