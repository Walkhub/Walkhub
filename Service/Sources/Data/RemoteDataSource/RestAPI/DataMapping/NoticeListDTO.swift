import Foundation

// MARK: - Data Transfer Object
struct NoticeListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "notice_list"
    }
    let list: [NoticeDTO]
}

// MARK: - Mappings to Domain
extension NoticeListDTO {
    func toDomain() -> [Notice] {
        return list.map { $0.toDomain() }
    }
}
