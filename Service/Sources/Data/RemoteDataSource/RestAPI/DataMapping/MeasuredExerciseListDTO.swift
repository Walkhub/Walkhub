import Foundation

// MARK: - Data Transfer Object
struct MeasuredExerciseListDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case list = "exercise_list"
    }
    let list: [MeasuredExerciseDTO]
}

// MARK: - Mappings to Domain
extension MeasuredExerciseListDTO {
    func toDomain() -> [MeasuredExercise] {
        return list.map { $0.toDomain() }
    }
}
