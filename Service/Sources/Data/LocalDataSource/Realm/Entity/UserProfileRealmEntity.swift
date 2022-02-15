import Foundation

import RealmSwift

class UserProfileRealmEntity: Object {

    @Persisted(primaryKey: true) var userID: Int = 0
    @Persisted var name: String = ""
    @Persisted var profileImageUrlString: String = ""
    @Persisted var school: String = ""
    @Persisted var grade: Int?
    @Persisted var classNum: Int?
    @Persisted var titleBadge: BadgeRealmEntity?
    @Persisted var level: LevelRealmEntity?
    @Persisted var isMyProfile: Bool = false

}

// MARK: Setup
extension UserProfileRealmEntity {
    func setup(profile: UserProfile, isMyProfile: Bool = false) {
        self.userID = profile.userID
        self.name = profile.name
        self.profileImageUrlString = profile.profileImageUrl.absoluteString
        self.school = profile.school
        self.grade = profile.grade
        self.classNum = profile.classNum
        self.titleBadge = BadgeRealmEntity().then {
            $0.setup(ownerID: profile.userID, badge: profile.titleBadge)
        }
        self.level = LevelRealmEntity().then {
            $0.setup(level: profile.level)
        }
        self.isMyProfile = isMyProfile
    }
}

// MARK: - Mappings to Domain
extension UserProfileRealmEntity {
    func toDomain() -> UserProfile {
        return .init(
            userID: userID,
            name: name,
            profileImageUrl: URL(string: profileImageUrlString)!,
            school: school,
            grade: grade,
            classNum: classNum,
            titleBadge: titleBadge!.toDomain(),
            level: level!.toDomain()
        )
    }
}
