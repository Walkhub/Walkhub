import Foundation

import RealmSwift
import Then

class ChallengeRealmEntity: Object {
    @Persisted(primaryKey: true) var compoundKey: String = ""

    @Persisted var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var startAt: String = ""
    @Persisted var endAt: String = ""
    @Persisted var goal: Int = 0
    @Persisted var goalScope: String = ""
    @Persisted var goalType: String = ""
    @Persisted var award: String = ""
    @Persisted var writer: WriterRealmEntity?
    @Persisted var participantCount: Int = 0
    @Persisted var participantList: List<ChallengeParticipantRealmEntity> = List<ChallengeParticipantRealmEntity>()
    @Persisted var isJoined: Bool = false
}

// MARK: Setup
extension ChallengeRealmEntity {

    func setup(challenge: Challenge, isJoined: Bool) {
        self.id = challenge.id
        self.name = challenge.name
        self.startAt = challenge.start.toDateString()
        self.endAt = challenge.end.toDateString()
        self.goal = challenge.goal
        self.goalScope = challenge.goalScope.rawValue
        self.award = challenge.award
        self.writer = WriterRealmEntity().then {
            $0.setup(writer: challenge.writer)
        }
        self.participantCount = challenge.participantCount
        self.participantList.append(objectsIn: challenge.participantList.map { participant in
            ChallengeParticipantRealmEntity().then { $0.setup(participant: participant) }
        })
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
            id: self.id,
            name: self.name,
            start: self.startAt.toDate(),
            end: self.endAt.toDate(),
            goal: self.goal,
            goalScope: ChallengeGoalScope(rawValue: self.goalScope)!,
            goalType: ExerciseGoalType(rawValue: self.goalType)!,
            award: self.award,
            writer: (self.writer?.toDomain())!,
            participantCount: self.participantCount,
            participantList: self.participantList.map { $0.toDomain() }
        )
    }
}
