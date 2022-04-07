import Foundation

struct SearchSchoolDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id = "school_id"
        case name = "school_name"
        case logoImageUrlString = "logo_image_url"
    }
    let id: Int
    let name: String
    let logoImageUrlString: String
}

extension SearchSchoolDTO {
    func toDomain() -> SearchSchool {
        return .init(
            id: id,
            name: name,
            logoImageUrl: URL(string: logoImageUrlString)!
        )
    }
}
