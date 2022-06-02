import Foundation

struct SearchSchoolRankDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "school_id"
        case name = "school_name"
        case ranking
        case logoImageUrlString = "logo_image_url"
        case walkCount = "walk_count"
        case userCount = "user_count"
    }
    let id: Int
    let name: String
    let ranking: Int
    let logoImageUrlString: String
    let walkCount: Int
    let userCount: Int
}

extension SearchSchoolRankDTO {
    func toDomain() -> School {
        return .init(
            schoolId: id,
            name: name,
            ranking: ranking ?? 0,
            logoImageUrl: URL(string: logoImageUrlString)!,
            walkCount: walkCount,
            userCount: userCount
        )
    }
}
