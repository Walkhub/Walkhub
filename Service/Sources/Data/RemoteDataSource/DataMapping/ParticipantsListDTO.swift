// swiftlint:disable nesting

import Foundation

// MARK: - Data Transfer Object
struct ParticipantsListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "challenge_participants_list"
    }
    let list: [Participants]
}

extension ParticipantsListDTO {
    struct Participants: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case gcn
            case profileImageUrlString = "profile_image_url"
        }
        let id: Int
        let name: String
        let gcn: String
        let profileImageUrlString: String
    }
}
