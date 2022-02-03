import Foundation

// MARK: - Data Transfer Object
struct BadgeListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "badge_list"
    }
    let list: [BadgeDTO]
}

// MARK: - Mappings to Domain
extension BadgeListDTO {
    func toDomain() -> [Badge] {
        return list.map { $0.toDomain() }
    }
}
