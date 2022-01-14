import Foundation

struct SchoolRankDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case mySchoolRank = "my_rank"
        case schoolList = "school_list"
    }
    let mySchoolRank: SchoolDTO
    let schoolList: [SchoolDTO]
}
