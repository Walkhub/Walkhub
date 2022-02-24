import Foundation

struct DefaultSchoolUserRankListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case rankList = "rank_list"
    }
    let rankList: [DefaultSchoolUserRankDTO]
}

extension DefaultSchoolUserRankListDTO {
    func toDomain() -> [DefaultSchoolUserRank] {
        return rankList.map { $0.toDomain() }
    }
}
