// swiftlint:disable nesting

import Foundation

// MARK: - Data Transfer Object
struct NoticeListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case noticeList = "notice_list"
    }
    let noticeList: [Notice]
}

extension NoticeListDTO {
    struct Notice: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case title
            case content
            case createdAt = "created_at"
            case writer
        }
        let id: Int
        let title: String
        let content: String
        let createdAt: String
        let writer: WriterDTO
    }
}
