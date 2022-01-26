import Foundation

// MARK: - Data Transfer Object
struct SchoolDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case agencyCode = "agency_code"
        case name
        case rank
        case logoImageUrlString = "logo_image_url"
        case walkCount = "walk_count"
    }
    let agencyCode: String
    let name: String
    let rank: Int
    let logoImageUrlString: String
    let walkCount: Int
}

// MARK: - Mappings to Domain
extension SchoolDTO {
    func toDomain() -> School {
        return .init(
            agencyCode: agencyCode,
            name: name,
            rank: rank,
            logoImageUrl: URL(string: logoImageUrlString)!,
            walkCount: walkCount
        )
    }
}
