import Foundation

public struct NotificationStatusListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "status_response_list"
    }
    let list: [NotificationStatusDTO]
}

extension NotificationStatusListDTO {
    func toDomain() -> [NotificationStatus] {
        return list.map { $0.toDomain() }
    }
}
