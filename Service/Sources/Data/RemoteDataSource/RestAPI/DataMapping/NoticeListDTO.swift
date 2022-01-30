import Foundation

// MARK: - Data Transfer Object
struct NoticeListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case noticeList = "notice_list"
    }
    let noticeList: [NoticeDTO]
}

// MARK: - Mappings to Domain
extension NoticeListDTO {
    func toDomain() -> [Notice] {
        return noticeList.map { $0.toDomain() }
    }
}
