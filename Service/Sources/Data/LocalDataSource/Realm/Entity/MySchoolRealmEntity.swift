import Foundation

import RealmSwift

class MySchoolRealmEntity: Object {
    @Persisted(primaryKey: true) var compoundKey: String = ""

    @Persisted var schoolId: Int = 0
    @Persisted var name: String = ""
    @Persisted var logoImageUrlString: String = ""
    @Persisted var grade: Int = 0
    @Persisted var classNum: Int = 0
}

extension MySchoolRealmEntity {
    func setup(school: MySchool) {
        self.schoolId = school.id
        self.name = school.name
        self.logoImageUrlString = school.logoImageUrl.absoluteString
        self.grade = school.grade
        self.classNum = school.classNum
        self.compoundKey = compoundKey
    }
    private func compoundKeyValue() -> String {
        return "\(schoolId)"
    }
}

extension MySchoolRealmEntity {
    func toDomain() -> MySchool {
        return .init(
            id: schoolId,
            name: name,
            logoImageUrl: URL(string: logoImageUrlString)!,
            grade: grade,
            classNum: classNum
        )
    }
}
