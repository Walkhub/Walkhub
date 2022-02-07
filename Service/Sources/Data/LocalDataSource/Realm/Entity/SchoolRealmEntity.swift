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

    func setup(
        agencyCode: String,
        name: String,
        rank: Int,
        logoImageUrlString: String,
        walkCount: Int
    ) {
        self.agencyCode = agencyCode
        self.name = name
        self.rank = rank
        self.logoImageUrlString = logoImageUrlString
        self.walkCount = walkCount
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
