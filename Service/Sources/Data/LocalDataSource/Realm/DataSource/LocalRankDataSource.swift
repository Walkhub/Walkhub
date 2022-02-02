import Foundation

import RxSwift

final class LocalRankDataSource {

    static let shared = LocalRankDataSource()

    private init() { }

    func fetchSchoolRank(dateType: DateType) -> Single<SchoolRank> {
        return Single.zip(
            fetchMySchoolRank(dateType: dateType),
            fetchSchoolRankList(dateType: dateType)
        ) { self.generateSchoolRank(mySchoolRank: $0, list: $1) }
    }

    func storeSchoolRank(schoolRank: SchoolRank, dateType: DateType) {
        storeMySchoolRank(school: schoolRank.mySchoolRank, dateType: dateType)
        storeSchoolRankList(rankList: schoolRank.schoolList, dateType: dateType)
    }

    func fetchUserRank(
        scope: Scope,
        dateType: DateType
    ) -> Single<UserRank> {
        return Single.zip(
            fetchMyRank(scope: scope, dateType: dateType),
            fetchUserRankList(scope: scope, dateType: dateType)
        ) { self.generateUserRank(myRank: $0, list: $1) }
    }

    func storeUserRank(
        userRank: UserRank,
        scope: Scope,
        dateType: DateType
    ) {
        storeMyRank(
            user: userRank.myRank,
            scope: scope,
            dateType: dateType
        )
        storeUserRankList(
            rankList: userRank.rankList,
            scope: scope,
            dateType: dateType
        )
    }

}

// MARK: School Rank
extension LocalRankDataSource {

    private func fetchMySchoolRank(dateType: DateType) -> Single<SchoolRankRealmEntity> {
        return RealmTask.shared.fetchObjects(
            for: SchoolRankRealmEntity.self,
               filter: QueryFilter.string(
                query: "dateType = '\(dateType.rawValue)' AND isMyRank = true"
               )
        ).map { $0[0] }
    }

    private func storeMySchoolRank(school: School, dateType: DateType) {
        let mySchoolRank = schoolToSchoolRankRealmEntity(
            school: school,
            dateType: dateType,
            isMySchoolRank: true
        )
        RealmTask.shared.set(mySchoolRank)
    }

    private func fetchSchoolRankList(dateType: DateType) -> Single<[SchoolRankRealmEntity]> {
        return RealmTask.shared.fetchObjects(
            for: SchoolRankRealmEntity.self,
               filter: QueryFilter.string(
                query: "dateType = '\(dateType.rawValue)' AND isMyRank = true"
               ),
               sortProperty: "rank"
        )
    }

    private func storeSchoolRankList(rankList: [School], dateType: DateType) {
        let schoolRankList = rankList.map {
            return schoolToSchoolRankRealmEntity(
                school: $0,
                dateType: dateType,
                isMySchoolRank: false
            )
        }
        RealmTask.shared.set(schoolRankList)
    }

    private func schoolToSchoolRankRealmEntity(
        school: School,
        dateType: DateType,
        isMySchoolRank: Bool
    ) -> SchoolRankRealmEntity {
        let schoolRankRealmEntity = SchoolRankRealmEntity()
        schoolRankRealmEntity.setup(
            agencyCode: school.agencyCode,
            name: school.name,
            rank: school.rank,
            logoImageUrlString: school.logoImageUrl.absoluteString,
            walkCount: school.walkCount,
            dateType: dateType,
            isMySchoolRank: isMySchoolRank
        )
        return schoolRankRealmEntity
    }

    private func generateSchoolRank(
        mySchoolRank: SchoolRankRealmEntity,
        list: [SchoolRankRealmEntity]
    ) -> SchoolRank {
        return .init(
            mySchoolRank: mySchoolRank.toDomain(),
            schoolList: list.map { $0.toDomain() }
        )
    }

}

// MARK: User Rank
extension LocalRankDataSource {

    private func fetchMyRank(
        scope: Scope,
        dateType: DateType
    ) -> Single<PersonRankRealmEntity> {
        return RealmTask.shared.fetchObjects(
            for: PersonRankRealmEntity.self,
               filter: QueryFilter.string(
                query: "scope = '\(scope.rawValue)' AND dateType = '\(dateType.rawValue)' AND isMyRank = true"
               )
        ).map { $0[0] }
    }

    private func storeMyRank(
        user: User,
        scope: Scope,
        dateType: DateType
    ) {
        let myRank = userToPersonRankRealmEntity(
            user: user,
            scope: scope,
            dateType: dateType,
            isMyRank: true
        )
        RealmTask.shared.set(myRank)
    }

    private func fetchUserRankList(
        scope: Scope,
        dateType: DateType
    ) -> Single<[PersonRankRealmEntity]> {
        return RealmTask.shared.fetchObjects(
            for: PersonRankRealmEntity.self,
               filter: QueryFilter.string(
                query: "scope = '\(scope.rawValue)' AND dateType = '\(dateType.rawValue)' AND isMyRank = false"
               ),
               sortProperty: "rank"
        )
    }

    private func storeUserRankList(
        rankList: [User],
        scope: Scope,
        dateType: DateType
    ) {
        let userRankList = rankList.map {
            return userToPersonRankRealmEntity(
                user: $0,
                scope: scope,
                dateType: dateType,
                isMyRank: false
            )
        }
        RealmTask.shared.set(userRankList)
    }

    private func userToPersonRankRealmEntity(
        user: User,
        scope: Scope,
        dateType: DateType,
        isMyRank: Bool
    ) -> PersonRankRealmEntity {
        let personRankRealmEntity = PersonRankRealmEntity()
        personRankRealmEntity.setup(
            userID: user.userID,
            name: user.name,
            rank: user.rank,
            grade: user.grade,
            classNum: user.classNum,
            profileImageUrlString: user.profileImageUrl.absoluteString,
            walkCount: user.walkCount,
            scope: scope,
            dateType: dateType,
            isMyRank: isMyRank
        )
        return personRankRealmEntity
    }

    private func generateUserRank(
        myRank: PersonRankRealmEntity,
        list: [PersonRankRealmEntity]
    ) -> UserRank {
        return .init(
            myRank: myRank.toDomain(),
            rankList: list.map { $0.toDomain() }
        )
    }

}
