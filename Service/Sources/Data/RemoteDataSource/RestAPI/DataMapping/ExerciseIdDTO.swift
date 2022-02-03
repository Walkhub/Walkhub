import Foundation

// MARK: - Data Transfer Object
struct ExerciseIdDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case exerciseId = "exercise_id"
    }
    let exerciseId: String
}

// MARK: - Mappings to Domain
extension ExerciseIdDTO {
    func toDomain() -> String {
        return exerciseId
    }
}
