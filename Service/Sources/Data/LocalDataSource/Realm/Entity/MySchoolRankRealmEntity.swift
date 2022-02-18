import Foundation

import RealmSwift

class MySchoolRankRealmEntity: MySchoolRealmEntity {
    @Persisted var dateType: String = DateType.day.rawValue
    @Persisted var isMyRank: Bool = true
}

extension MySchoolRankRealmEntity {
    func setup(
        school: MySchool,
        dateType: DateType
    ) {
        super.setup(school: school)
        self.dateType = dateType.rawValue
    }
}
