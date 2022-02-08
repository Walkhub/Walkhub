import Foundation

import RealmSwift

class PersonRealmEntity: Object {

    @Persisted(primaryKey: true) var compoundKey: String = ""

    @Persisted var userID: Int = 0
    @Persisted var name: String = ""
    @Persisted var rank: Int = 0
    @Persisted var grade: Int = 0
    @Persisted var classNum: Int = 0
    @Persisted var profileImageUrlString: String = ""
    @Persisted var walkCount: Int = 0

}

// MARK: Setup
extension PersonRealmEntity {

    func setup(person: User) {
        self.userID = person.userID
        self.name = person.name
        self.rank = person.rank
        self.grade = person.grade
        self.classNum = person.classNum
        self.profileImageUrlString = person.profileImageUrl.absoluteString
        self.walkCount = person.walkCount
        self.compoundKey = compoundKeyValue()
    }

    private func compoundKeyValue() -> String {
        return "\(userID)"
    }

}

// MARK: - Mappings to Domain
extension PersonRealmEntity {
    func toDomain() -> User {
        return .init(
            userID: userID,
            name: name,
            rank: rank,
            grade: grade,
            classNum: classNum,
            profileImageUrl: URL(string: profileImageUrlString)!,
            walkCount: walkCount
        )
    }
}
