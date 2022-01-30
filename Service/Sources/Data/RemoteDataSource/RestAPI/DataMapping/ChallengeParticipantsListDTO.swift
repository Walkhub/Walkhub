import Foundation

struct ChallengeParticipantListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "challenge_participants_list"
    }
    let list: [ChallengeParticipantDTO]
}
