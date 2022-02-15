import Foundation

struct SearchSchoolRankListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "school_list"
    }
    let list: [SearchSchoolRankDTO]
}
