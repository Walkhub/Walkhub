import Foundation

import RealmSwift

class RankedPersonRealmEntity: Object {

    @Persisted(primaryKey: true) var compoundKey: String = ""

    @Persisted var userId: Int = 0
    @Persisted var name: String = ""
    @Persisted var ranking: Int = 0
    @Persisted var profileImageUrlString: String = ""
    @Persisted var walkCount: Int = 0

}

extension RankedPersonRealmEntity {

    func setup(user: RankedUser) {
        self.userId = user.userId
        self.name = user.name
        self.ranking = user.ranking
        self.profileImageUrlString = user.profileImageUrl.absoluteString
        self.walkCount = user.walkCount
        self.compoundKey = compoundKeyValue()
    }

    private func compoundKeyValue() -> String {
        return "/\(userId)"
    }
}

extension RankedPersonRealmEntity {
    func toDomain() -> RankedUser {
        return .init(
            userId: self.userId,
            name: self.name,
            ranking: self.ranking,
            profileImageUrl: URL(string: self.profileImageUrlString)!,
            walkCount: self.walkCount)
    }
}
