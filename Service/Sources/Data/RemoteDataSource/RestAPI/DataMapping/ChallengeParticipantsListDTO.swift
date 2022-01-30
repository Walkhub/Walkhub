// swiftlint:disable nesting

import Foundation

// MARK: - Data Transfer Object
struct ChallengeParticipantsListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "challenge_participants_list"
    }
    let list: [Participants]
}

extension ChallengeParticipantsListDTO {
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
