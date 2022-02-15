import Foundation

import RxSwift

class DefaultRankRepository: RankRepository {

    private let remoteRankDataSource = RemoteRankDataSource.shared
    private let localRankDataSource = LocalRankDataSource.shared

    func fetchSchoolRank(dateType: DateType) -> Observable<SchoolRank> {
        return OfflineCacheUtil<SchoolRank>()
            .localData { self.localRankDataSource.fetchSchoolRank(dateType: dateType) }
            .remoteData { self.remoteRankDataSource.fetchSchoolRank(dateType: dateType) }
            .doOnNeedRefresh { self.localRankDataSource.storeSchoolRank(schoolRank: $0, dateType: dateType) }
            .createObservable()
    }

    func searchSchool(name: String) -> Single<[School]> {
        return remoteRankDataSource.searchSchool(name: name)
    }

    func fetchUserSchoolRank(
        scope: Scope,
        dateType: DateType
    ) -> Observable<UserRank> {
        return OfflineCacheUtil<UserRank>()
            .localData { self.localRankDataSource.fetchUserRank(scope: scope, dateType: dateType) }
            .remoteData { self.remoteRankDataSource.fetchUserSchoolRank(scope: scope,dateType: dateType) }
            .doOnNeedRefresh { self.localRankDataSource.storeUserRank(userRank: $0, scope: scope, dateType: dateType) }
            .createObservable()
    }

    func fetchUserRank(
        scope: Scope,
        dateTypa: DateType,
        schoolId: String
    ) -> Single<[User]> {
        return remoteRankDataSource.fetchUserRank(
            scope: scope,
            dateTypa: dateTypa,
            schoolId: schoolId
        )
    }

    func searchUser(
        name: String,
        scope: Scope,
        schoolId: String,
        grade: Int,
        classNum: Int
    ) -> Single<[User]> {
        return remoteRankDataSource.searchUser(
            name: name,
            scope: scope,
            schoolId: schoolId,
            grade: grade,
            classNum: classNum
        )
    }

}
