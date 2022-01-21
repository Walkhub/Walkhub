import Foundation

// MARK: - Data Transfer Object
struct UserRankDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case myRank = "my_rank"
        case rankList = "rank_list"
    }
    let myRank: UserDTO
    let rankList: [UserDTO]
}
