import Foundation

struct MyBadgeListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "my_badge_list"
    }
    let list: [MyBadgeDTO]
}
