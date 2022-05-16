import Foundation

import RealmSwift

class JoinedChallengeRealmEntity: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var imageUrlString: String = ""
    @Persisted var start: String = ""
    @Persisted var end: String = ""
    @Persisted var goal: Int = 0
    @Persisted var goalScope: String = ""
    @Persisted var goalType: String = ""
    @Persisted var totalValue: Int = 0
    @Persisted var writer: WriterRealmEntity?
}

extension JoinedChallengeRealmEntity {
    func setup(list: JoinedChallenge) {
        self.name = list.name
        self.imageUrlString = list.imageUrl.absoluteString
        self.start = list.start.toDateString()
        self.end = list.end.toDateString()
        self.goal = list.goal
        self.goalScope = list.goalScope.rawValue
        self.goalType = list.goalType.rawValue
        self.totalValue = list.totalValue
        self.writer = WriterRealmEntity().then {
            $0.setup(writer: list.writer)
        }
    }
}

extension JoinedChallengeRealmEntity {
    func toDomain() -> JoinedChallenge {
        return .init(
            id: self.id,
            name: self.name,
            imageUrl: URL(string: self.imageUrlString)!,
            start: self.start.toDate(),
            end: self.end.toDate(),
            goal: self.goal,
            goalScope: ChallengeGoalScope(rawValue: self.goalScope) ?? .day,
            goalType: ExerciseGoalType(rawValue: self.goalType) ?? .walkCount,
            totalValue: self.totalValue,
            writer: self.writer!.toDomain()
        )
    }
}
