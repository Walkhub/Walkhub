import Foundation

import RealmSwift
import Then

class ChallengeRealmEntity: Object {
    @Persisted(primaryKey: true) var compoundKey: String = ""

    @Persisted var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var startAt: String = ""
    @Persisted var endAt: String = ""
    @Persisted var imageUrlString: String = ""
    @Persisted var userScope: String = ""
    @Persisted var goalScope: String = ""
    @Persisted var goalType: String = ""
    @Persisted var writer: WriterRealmEntity?
    @Persisted var isJoined: Bool = false
}

// MARK: Setup
extension ChallengeRealmEntity {

    func setup(challenge: Challenge, isJoined: Bool) {
        self.id = challenge.id
        self.name = challenge.name
        self.startAt = challenge.start.toDateWithTimeString()
        self.endAt = challenge.end.toDateWithTimeString()
        self.imageUrlString = challenge.imageUrl.absoluteString
        self.userScope = challenge.userScope.rawValue
        self.goalScope = challenge.goalScope.rawValue
        self.goalType = challenge.goalType.rawValue
        self.writer = WriterRealmEntity().then {
            $0.setup(writer: challenge.writer)
        }
        self.isJoined = isJoined
    }

    private func compoundKeyValue() -> String {
        return "\(id)\(isJoined)"
    }

}

// MARK: - Mappings to Domain
extension ChallengeRealmEntity {
    func toDomain() -> Challenge {
        return .init(
            id: id,
            name: name,
            start: startAt.toDateWithTime(),
            end: endAt.toDateWithTime(),
            imageUrl: URL(string: imageUrlString)!,
            userScope: GroupScope(rawValue: userScope)!,
            goalScope: ChallengeGoalScope(rawValue: goalScope)!,
            goalType: ExerciseGoalType(rawValue: goalType)!,
            writer: writer!.toDomain()
        )
    }
}
