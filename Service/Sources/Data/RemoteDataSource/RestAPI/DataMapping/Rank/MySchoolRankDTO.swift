import Foundation

struct MySchoolRankDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case mySchoolRank = "my_school_rank"
    }
    let mySchoolRank: MySchoolDTO
}

