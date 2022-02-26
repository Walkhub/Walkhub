import Foundation

import RealmSwift

class PersonRankRealmEntity: RankedPersonRealmEntity {

    @Persisted var scope: String = GroupScope.class.rawValue
    @Persisted var dateType: String = DateType.day.rawValue
    @Persisted var isMyRank: Bool = false

}

// MARK: Setup
extension PersonRankRealmEntity {

    func setup(
        person: RankedUser,
        scope: GroupScope,
        dateType: DateType,
        isMyRank: Bool = false
    ) {
        super.setup(user: person)
        self.scope = scope.rawValue
        self.dateType = dateType.rawValue
        self.isMyRank = isMyRank
        self.compoundKey = compoundKeyValue()
    }

    private func compoundKeyValue() -> String {
        return "\(ranking)\(scope)\(dateType)\(isMyRank)"
    }

}
