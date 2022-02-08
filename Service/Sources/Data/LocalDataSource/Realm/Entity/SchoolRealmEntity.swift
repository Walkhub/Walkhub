import Foundation

import RealmSwift

class SchoolRealmEntity: Object {

    @Persisted(primaryKey: true) var compoundKey: String = ""

    @Persisted var agencyCode: String = ""
    @Persisted var name: String = ""
    @Persisted var rank: Int = 0
    @Persisted var logoImageUrlString: String = ""
    @Persisted var walkCount: Int = 0

}

// MARK: Setup
extension SchoolRealmEntity {

    func setup(school: School) {
        self.agencyCode = school.agencyCode
        self.name = school.name
        self.rank = school.rank
        self.logoImageUrlString = school.logoImageUrl.absoluteString
        self.walkCount = school.walkCount
        self.compoundKey = compoundKeyValue()
    }

    private func compoundKeyValue() -> String {
        return "\(agencyCode)"
    }

}

// MARK: - Mappings to Domain
extension SchoolRealmEntity {
    func toDomain() -> School {
        return .init(
            agencyCode: agencyCode,
            name: name,
            rank: rank,
            logoImageUrl: URL(string: logoImageUrlString)!,
            walkCount: walkCount
        )
    }
}
