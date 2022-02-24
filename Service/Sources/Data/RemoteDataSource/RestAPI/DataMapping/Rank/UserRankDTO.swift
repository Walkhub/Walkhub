import Foundation

// MARK: - Data Transfer Object
struct UserRankDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case myRank = "my_ranking"
        case rankList = "ranking_list"
    }
    let myRank: RankedUserDTO
    let rankList: [RankedUserDTO]
}

// MARK: - Mappings to Domain
extension UserRankDTO {
    func toDomain() -> UserRank {
        return .init(
            myRank: myRank.toDomain(),
            rankList: rankList.map { $0.toDomain() })
    }
}
