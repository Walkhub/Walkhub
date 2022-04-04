import Foundation

import RealmSwift

class RecordExerciseRealmEntity: Object {

    @Persisted(primaryKey: true) var exerciseId: Int = 0
    @Persisted var goal: Int = 0
    @Persisted var goalType: String = ExerciseGoalType.distance.rawValue

}

extension RecordExerciseRealmEntity {
    func setup(
        _ exerciseID: Int,
        _ goal: Int,
        _ goalType: ExerciseGoalType
    ) {
        self.exerciseId = exerciseId
        self.goal = goal
        self.goalType = goalType.rawValue
    }
}

extension RecordExerciseRealmEntity {
    func toDomain() -> RecordExercise {
        return .init(
            exerciseId: exerciseId,
            goal: goal,
            goalType: ExerciseGoalType(rawValue: goalType)!
        )
    }
}
