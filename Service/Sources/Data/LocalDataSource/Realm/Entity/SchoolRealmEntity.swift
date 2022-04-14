import Foundation

import RealmSwift

class SchoolRealmEntity: Object {

    @Persisted(primaryKey: true) var compoundKey: String = ""

    @Persisted var schoolId: Int = 0
    @Persisted var name: String = ""
    @Persisted var rank: Int = 0
    @Persisted var logoImageUrlString: String = ""
    @Persisted var walkCount: Int = 0
    @Persisted var userCount: Int = 0

}

// MARK: Setup
extension SchoolRealmEntity {

    func setup(school: School) {
        self.schoolId = school.schoolId
        self.name = school.name
        self.rank = school.ranking
        self.logoImageUrlString = school.logoImageUrl.absoluteString
        self.walkCount = school.walkCount
        self.userCount = school.userCount
        self.compoundKey = compoundKeyValue()
    }

    private func compoundKeyValue() -> String {
        return "\(schoolId)"
    }

}

// MARK: - Mappings to Domain
extension SchoolRealmEntity {
    func toDomain() -> School {
        return .init(
            schoolId: schoolId,
            name: name,
            ranking: rank,
            logoImageUrl: URL(string: logoImageUrlString)!,
            walkCount: walkCount,
            userCount: userCount
        )
    }
}
