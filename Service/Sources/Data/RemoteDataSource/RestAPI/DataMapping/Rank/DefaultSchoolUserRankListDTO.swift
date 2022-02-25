import Foundation

struct DefaultSchoolUserRankListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case rankList = "rank_list"
    }
    let rankList: [RankedUserDTO]
}

extension DefaultSchoolUserRankListDTO {
    func toDomain() -> [RankedUser] {
        return rankList.map { $0.toDomain() }
    }
}
