import Foundation

import RealmSwift

class ChallengeParticipantRealmEntity: Object {
    @Persisted(primaryKey: true) var id: Int = 0

    @Persisted var name: String = ""
    @Persisted var profileImageUrlStirng: String = ""
}

extension ChallengeParticipantRealmEntity {

    func setup(participant: ChallengeParticipant) {
        self.name = participant.name
        self.profileImageUrlStirng = participant.profileImageUrl.absoluteString
    }
}

extension ChallengeParticipantRealmEntity {

    func toDomain() -> ChallengeParticipant {
        return .init(
            id: self.id,
            name: self.name,
            profileImageUrl: URL(string: self.profileImageUrlStirng)!
        )
    }
}
