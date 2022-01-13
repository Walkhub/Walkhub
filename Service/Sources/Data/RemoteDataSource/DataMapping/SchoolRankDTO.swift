import Foundation

struct SchoolRankDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case mySchoolRank = "my_rank"
        case schoolList = "school_list"
    }
    let mySchoolRank: SchoolRank
    let schoolList: [School]
}

extension SchoolRankDTO {
    struct SchoolRank: Decodable {
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
    struct School: Decodable {
        private enum CodingKeys: String, CodingKey {
            case agencyCode = "agency_code"
            case name
            case logoImageUrlString = "logo_image_url"
            case walkCount = "walk_count"
        }
        let agencyCode: String
        let name: String
        let logoImageUrlString: String
        let walkCount: Int
    }
}
