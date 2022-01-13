import Foundation

struct BadgeListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case badgeList = "badge_list"
    }
    let badgeList: [BadgeInformation]
}

extension BadgeListDTO {
    struct BadgeInformation: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case imageString = "image_url"
        }
        let id: Int
        let name: String
        let imageString: String
    }
}
