import Foundation

struct SchoolListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case schoolList = "school_list"
    }
    let schoolList: [School]
}

extension SchoolListDTO {
    struct School: Decodable {
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
}
