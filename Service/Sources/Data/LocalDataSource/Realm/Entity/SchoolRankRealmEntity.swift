// swiftlint:disable function_parameter_count

import Foundation

import RealmSwift

class SchoolRankRealmEntity: SchoolRealmEntity {

    @Persisted var dateType: String = DateType.day.rawValue
    @Persisted var isMySchoolRank: Bool = false

}

// MARK: Setup
extension SchoolRankRealmEntity {

    func setup(
        agencyCode: String,
        name: String,
        rank: Int,
        logoImageUrlString: String,
        walkCount: Int,
        dateType: DateType,
        isMySchoolRank: Bool
    ) {
        super.setup(
            agencyCode: agencyCode,
            name: name,
            rank: rank,
            logoImageUrlString: logoImageUrlString,
            walkCount: walkCount
        )
        self.dateType = dateType.rawValue
        self.isMySchoolRank = isMySchoolRank
        self.compoundKey = compoundKeyValue()
    }

    private func compoundKeyValue() -> String {
        return "\(rank)\(dateType)\(isMySchoolRank)"
    }

}
