import Foundation

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
            case createdAt = "created_at"
            case writer
        }
        let id: Int
        let title: String
        let createdAt: String
        let writer: WriterDTO
    }
}
