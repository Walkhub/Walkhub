import Foundation

import RealmSwift

class MySchoolRankRealmEntity: MySchoolRealmEntity {
    @Persisted var dateType: String = DateType.day.rawValue
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
