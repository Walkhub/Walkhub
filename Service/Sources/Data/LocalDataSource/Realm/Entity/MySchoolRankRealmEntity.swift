import Foundation

import RealmSwift

class MySchoolRankRealmEntity: MySchoolRealmEntity {
    @Persisted var isMyRank: Bool = true
}
