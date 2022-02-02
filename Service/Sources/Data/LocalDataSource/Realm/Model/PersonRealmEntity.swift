// swiftlint:disable function_parameter_count

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

    func setup(
        userID: Int,
        name: String,
        rank: Int,
        grade: Int,
        classNum: Int,
        profileImageUrlString: String,
        walkCount: Int
    ) {
        self.userID = userID
        self.name = name
        self.rank = rank
        self.grade = grade
        self.classNum = classNum
        self.profileImageUrlString = profileImageUrlString
        self.walkCount = walkCount
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
