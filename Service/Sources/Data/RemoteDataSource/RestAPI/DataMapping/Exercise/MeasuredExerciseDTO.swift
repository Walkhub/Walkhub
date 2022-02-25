import Foundation

// MARK: - Data Transfer Object
struct MeasuredExerciseDTO: Decodable {
    private enum CodingKeys: String, CodingKey {
        case exerciseId = "exercise_id"
        case imageUrlString = "image_url"
        case startAt = "start_at"
        case latitude
        case longitude
    }
    let exerciseId: Int
    let imageUrlString: String
    let startAt: String
    let latitude: Double
    let longitude: Double
}

// MARK: - Mappings to Domain
extension MeasuredExerciseDTO {
    func toDomain() -> MeasuredExercise {
        return .init(
            exerciseId: exerciseId,
            imageUrl: URL(string: imageUrlString)!,
            startAt: startAt.toDate(),
            latitude: latitude,
            longitude: longitude
        )
    }
}
