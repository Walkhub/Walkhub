import Foundation

// MARK: - Data Transfer Object
struct UserRankDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case isJoinedClass = "is_joined_class"
        case myRank = "my_ranking"
        case rankList = "rank_list"
    }
    let isJoinedClass: Bool
    let myRank: RankedUserDTO
    let rankList: [RankedUserDTO]
}

// MARK: - Mappings to Domain
extension UserRankDTO {
    func toDomain() -> UserRank {
        return .init(
            isJoinedClass: isJoinedClass,
            myRank: myRank.toDomain(),
            rankList: rankList.map { $0.toDomain() })
    }
}
