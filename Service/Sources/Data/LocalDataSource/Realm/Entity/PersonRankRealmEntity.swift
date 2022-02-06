// swiftlint:disable function_parameter_count

import Foundation

import RealmSwift

class PersonRankRealmEntity: PersonRealmEntity {

    @Persisted var scope: String = Scope.class.rawValue
    @Persisted var dateType: String = DateType.day.rawValue
    @Persisted var isMyRank: Bool = false

}

// MARK: Setup
extension PersonRankRealmEntity {

    func setup(
        userID: Int,
        name: String,
        rank: Int,
        grade: Int,
        classNum: Int,
        profileImageUrlString: String,
        walkCount: Int,
        scope: Scope,
        dateType: DateType,
        isMyRank: Bool = false
    ) {
        super.setup(
            userID: userID,
            name: name,
            rank: rank,
            grade: grade,
            classNum: classNum,
            profileImageUrlString: profileImageUrlString,
            walkCount: walkCount
        )
        self.scope = scope.rawValue
        self.dateType = dateType.rawValue
        self.isMyRank = isMyRank
        self.compoundKey = compoundKeyValue()
    }

    private func compoundKeyValue() -> String {
        return "\(rank)\(scope)\(dateType)\(isMyRank)"
    }

}
