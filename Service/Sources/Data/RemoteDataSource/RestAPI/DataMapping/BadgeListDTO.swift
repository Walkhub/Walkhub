import Foundation

// MARK: - Data Transfer Object
struct BadgeListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case badgeList = "badge_list"
    }
    let badgeList: [BadgeDTO]
}

// MARK: - Mappings to Domain
extension BadgeListDTO {
    func toDomain() -> [Badge] {
        return badgeList.map { $0.toDomain() }
    }
}
