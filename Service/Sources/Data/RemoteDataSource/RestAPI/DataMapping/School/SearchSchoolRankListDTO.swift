import Foundation

struct SearchSchoolRankListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "school_list"
    }
    let list: [SearchSchoolRankDTO]
}

extension SearchSchoolRankListDTO {
    func toDoamin() -> [SearchSchoolRank] {
        return list.map { $0.toDomain() }
    }
}
