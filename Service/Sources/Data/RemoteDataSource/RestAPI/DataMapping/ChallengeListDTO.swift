import Foundation

// MARK: - Data Transfer Object
struct ChallengeListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "challenge_list"
    }
    let list: [ChallengeDTO]
}

// MARK: - Mappings to Domain
extension ChallengeListDTO {
    func toDomain() -> [Challenge] {
        return list.map { $0.toDomain() }
    }
}
