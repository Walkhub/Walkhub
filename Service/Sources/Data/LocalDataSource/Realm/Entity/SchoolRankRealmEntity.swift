import Foundation

import RealmSwift

class SchoolRankRealmEntity: SchoolRealmEntity {

    @Persisted var dateType: String = DateType.day.rawValue
    @Persisted var isMySchoolRank: Bool = false

}

// MARK: Setup
extension SchoolRankRealmEntity {

    func setup(
        school: School,
        dateType: DateType,
        isMySchoolRank: Bool
    ) {
        super.setup(school: school)
        self.dateType = dateType.rawValue
        self.isMySchoolRank = isMySchoolRank
        self.compoundKey = compoundKeyValue()
    }

    private func compoundKeyValue() -> String {
        return "\(rank)\(dateType)\(isMySchoolRank)"
    }

}
