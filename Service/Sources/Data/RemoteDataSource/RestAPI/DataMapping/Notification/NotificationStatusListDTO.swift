import Foundation

public struct NotificationStatusListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "topic_whether_list"
    }
    let list: [NotificationStatusDTO]
}

extension NotificationStatusListDTO {
    func toDomain() -> [NotificationStatus] {
        return list.map { $0.toDomain() }
    }
}
