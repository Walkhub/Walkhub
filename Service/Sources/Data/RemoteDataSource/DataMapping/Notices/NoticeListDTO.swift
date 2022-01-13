import Foundation

struct NoticeListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case noticeList = "notice_list"
    }
    let noticeList: [NoticeInformation]
}

extension NoticeListDTO {
    struct NoticeInformation: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case title
            case createdAt = "created_at"
            case writer
        }
        let id: Int
        let title: String
        let createdAt: String
        let writer: Writer
    }
    struct Writer: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case profileImageUrlString = "profile_image_url"
        }
        let id: Int
        let name: String
        let profileImageUrlString: String
    }
}
