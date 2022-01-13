import Foundation

struct ParticipantsDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case participantsList = "challenge_participants_list"
    }
    let participantsList: [Participants]
}

extension ParticipantsDTO {
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
