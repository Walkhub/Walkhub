import Foundation

struct BadgeListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case badgeList = "badge_list"
    }
    let badgeList: [BadgeDTO]
}
