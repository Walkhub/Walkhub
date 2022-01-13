import Foundation

struct ChallengeListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case challengeList = "challenge_list"
    }
    let challengeList: [ChallengeList]
}

extension ChallengeListDTO {
    struct ChallengeList: Decodable {
        private enum CodingKeys: String, CodingKey {
            case id
            case name
            case start = "start_at"
            case end = "end_at"
            case imageUrlString = "image_url"
            case scope
        }
        let id: Int
        let name: String
        let start: String
        let end: String
        let imageUrlString: String
        let scope: String
    }
}
