import Foundation

import RealmSwift

class MeasuredExerciseRealmEntity: Object {

    @Persisted(primaryKey: true) var exerciseId: Int = 0
    @Persisted var imageUrlString: String = ""
    @Persisted var startAt: String = ""
    @Persisted var latitude: Double = 0.0
    @Persisted var longitude: Double = 0.0

}

// MARK: Setup
extension MeasuredExerciseRealmEntity {
    func setup(measuredExercise: MeasuredExercise) {
        self.exerciseId = measuredExercise.exerciseId
        self.imageUrlString = measuredExercise.imageUrl.absoluteString
        self.startAt = measuredExercise.startAt.toDateString()
        self.latitude = measuredExercise.latitude
        self.longitude = measuredExercise.longitude
    }
}

// MARK: - Mappings to Domain
extension MeasuredExerciseRealmEntity {
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
