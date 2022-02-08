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
        person: User,
        scope: Scope,
        dateType: DateType,
        isMyRank: Bool = false
    ) {
        super.setup(person: person)
        self.scope = scope.rawValue
        self.dateType = dateType.rawValue
        self.isMyRank = isMyRank
        self.compoundKey = compoundKeyValue()
    }

    private func compoundKeyValue() -> String {
        return "\(rank)\(scope)\(dateType)\(isMyRank)"
    }

}
