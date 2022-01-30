import Foundation

struct ChallengeParticipantsListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "challenge_participants_list"
    }
    let list: [ChallengeParticipantsDTO]
}
