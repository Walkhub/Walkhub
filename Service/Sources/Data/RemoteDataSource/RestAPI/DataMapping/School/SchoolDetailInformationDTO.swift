import Foundation

struct SchoolDetailInformationDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case totalWalkCount = "total_walk_count"
        case date
        case totalUserCount = "total_user_count"
        case ranking
    }
    let totalWalkCount: Int
    let date: String
    let totalUserCount: Int
    let ranking: Int
}

extension SchoolDetailInformationDTO {
    func toDomain() -> SchoolDetailInformtaion {
        return .init(
            totalWalkCount: totalWalkCount,
            date: date.toDate(),
            totalUserCount: totalUserCount,
            ranking: ranking
        )
    }
}
