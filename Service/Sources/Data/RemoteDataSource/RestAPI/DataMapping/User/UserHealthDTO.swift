import Foundation

struct UserHealthDTO: Decodable {
    let height: Float?
    let weight: Int?
    let sex: String
}

extension UserHealthDTO {
    func toDomain() -> UserHealth {
        return .init(
            height: height ?? 0,
            weight: weight ?? 0,
            sex: Sex(rawValue: sex) ?? .noAnswer
        )
    }
}
