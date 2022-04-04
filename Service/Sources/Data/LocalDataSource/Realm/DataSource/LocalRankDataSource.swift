import Foundation

import RxSwift

final class LocalRankDataSource {

    static let shared = LocalRankDataSource()

    private let realmTask = RealmTask.shared

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
        scope: GroupScope,
        dateType: DateType
    ) -> Single<UserRank> {
        return Single.zip(
            fetchMyRank(scope: scope, dateType: dateType),
            fetchUserRankList(scope: scope, dateType: dateType)
        ) { self.generateUserRank(myRank: $0, list: $1) }
    }

    func storeUserRank(
        userRank: UserRank,
        scope: GroupScope,
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

    private func fetchMySchoolRank(dateType: DateType) -> Single<MySchoolRankRealmEntity> {
        return realmTask.fetchObjects(
            for: MySchoolRankRealmEntity.self,
               filter: QueryFilter.string(
                query: "dateType = '\(dateType.rawValue)'"
               )
        ).map { $0.first! }
    }

    private func storeMySchoolRank(school: MySchool, dateType: DateType) {
        let mySchoolRank = mySchoolToSchoolRankRealmEntity(
            school: school,
            dateType: dateType
        )
        realmTask.set(mySchoolRank)
    }

    private func fetchSchoolRankList(dateType: DateType) -> Single<[SchoolRankRealmEntity]> {
        return realmTask.fetchObjects(
            for: SchoolRankRealmEntity.self,
               filter: QueryFilter.string(
                query: "dateType = '\(dateType.rawValue)' AND isMySchoolRank = true"
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
        realmTask.set(schoolRankList)
    }

    private func schoolToSchoolRankRealmEntity(
        school: School,
        dateType: DateType,
        isMySchoolRank: Bool
    ) -> SchoolRankRealmEntity {
        let schoolRankRealmEntity = SchoolRankRealmEntity()
        schoolRankRealmEntity.setup(
            school: school,
            dateType: dateType,
            isMySchoolRank: isMySchoolRank
        )
        return schoolRankRealmEntity
    }

    private func mySchoolToSchoolRankRealmEntity(
        school: MySchool,
        dateType: DateType
    ) -> MySchoolRankRealmEntity {
        let mySchoolRankRealmEntity = MySchoolRankRealmEntity()
        mySchoolRankRealmEntity.setup(
            school: school,
            dateType: dateType
        )
        return mySchoolRankRealmEntity
    }

    private func generateSchoolRank(
        mySchoolRank: MySchoolRankRealmEntity,
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
        scope: GroupScope,
        dateType: DateType
    ) -> Single<PersonRankRealmEntity> {
        return realmTask.fetchObjects(
            for: PersonRankRealmEntity.self,
               filter: QueryFilter.string(
                query: "scope = '\(scope.rawValue)' AND dateType = '\(dateType.rawValue)' AND isMyRank = true"
               )
        ).map { $0.first! }
    }

    private func storeMyRank(
        user: RankedUser,
        scope: GroupScope,
        dateType: DateType
    ) {
        let myRank = userToPersonRankRealmEntity(
            user: user,
            scope: scope,
            dateType: dateType,
            isMyRank: true
        )
        realmTask.set(myRank)
    }

    private func fetchUserRankList(
        scope: GroupScope,
        dateType: DateType
    ) -> Single<[PersonRankRealmEntity]> {
        return realmTask.fetchObjects(
            for: PersonRankRealmEntity.self,
               filter: QueryFilter.string(
                query: "scope = '\(scope.rawValue)' AND dateType = '\(dateType.rawValue)' AND isMyRank = false"
               ),
               sortProperty: "ranking"
        )
    }

    private func storeUserRankList(
        rankList: [RankedUser],
        scope: GroupScope,
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
        realmTask.set(userRankList)
    }

    private func userToPersonRankRealmEntity(
        user: RankedUser,
        scope: GroupScope,
        dateType: DateType,
        isMyRank: Bool
    ) -> PersonRankRealmEntity {
        let personRankRealmEntity = PersonRankRealmEntity()
        personRankRealmEntity.setup(person: user, scope: scope, dateType: dateType)
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
