import Foundation

// MARK: - Data Transfer Object
struct SchoolRankDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case mySchoolRank = "my_rank"
        case schoolList = "school_list"
    }
    let mySchoolRank: MySchoolDTO
    let schoolList: [SchoolDTO]
}

// MARK: - Mappings to Domain
extension SchoolRankDTO {
    func toDomain() -> SchoolRank {
        return .init(
            mySchoolRank: mySchoolRank.toDomain(),
            schoolList: schoolList.map { $0.toDomain() }
        )
    }
}
