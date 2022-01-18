import Foundation

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