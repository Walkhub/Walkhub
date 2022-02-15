import Foundation

// MARK: - Data Transfer Object
struct ExercisesIdDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case exercisesId = "exercise_id"
    }
    let exercisesId: Int
}

// MARK: - Mappings to Domain
extension ExercisesIdDTO {
    func toDomain() -> Int {
        return exercisesId
    }
}
