import Foundation

struct UserRankDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case myRank = "my_rank"
        case rankList = "rank_list"
    }
    let myRank: MyRank
    let rankList: [Rank]
}

extension UserRankDTO {
    struct MyRank: Decodable {
        private enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case name
            case rank
            case profileImageUrlString = "profile_image_url"
            case walkCount = "walk_count"
        }
        let userID: Int
        let name: String
        let rank: Int
        let profileImageUrlString: String
        let walkCount: Int
    }
    struct Rank: Decodable {
        private enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case name
            case profileImageUrlString = "profile_image_url"
            case walkCount = "walk_count"
        }
        let userID: Int
        let name: String
        let profileImageUrlString: String
        let walkCount: Int
    }
}
