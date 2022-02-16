import Foundation

struct SchoolDetailsDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case totalUserCount = "total_user_count"
        case weekTotalWalkCount = "week_toal_walk_count"
        case monthTotalWalkCount = "month_total_walk_count"
        case weekRanking = "week_ranking"
        case monthRanking = "month_ranking"
    }
    let totalUserCount: Int
    let weekTotalWalkCount: Int
    let monthTotalWalkCount: Int
    let weekRanking: Int
    let monthRanking: Int
}

extension SchoolDetailsDTO {
    func toDomain() -> SchoolDetails {
        return .init(
            totalUserCount: totalUserCount,
            weekTotalWalkCount: weekTotalWalkCount,
            monthTotalWalkCount: monthTotalWalkCount,
            weekRanking: weekRanking,
            monthRanking: monthRanking
        )
    }
}
