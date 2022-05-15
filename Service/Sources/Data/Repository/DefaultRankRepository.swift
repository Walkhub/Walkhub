import Foundation

import RxSwift

class DefaultRankRepository: RankRepository {

    private let remoteRankDataSource = RemoteRankDataSource.shared
    private let localRankDataSource = LocalRankDataSource.shared

    func fetchSchoolRank() -> Observable<MySchool> {
        return OfflineCacheUtil<MySchool>()
            .localData { self.localRankDataSource.fetchMySchoolRank() }
            .remoteData { self.remoteRankDataSource.fetchSchoolRank() }
            .doOnNeedRefresh { self.localRankDataSource.storeMySchoolRank(school: $0)}
            .createObservable()
    }

    func searchSchool(name: String?, dateType: DateType) -> Observable<[School]> {
        return remoteRankDataSource.searchSchool(name: name, dateType: dateType)
            .asObservable()
    }

    func fetchUserSchoolRank(
        scope: GroupScope,
        dateType: DateType
    ) -> Observable<UserRank> {
        return OfflineCacheUtil<UserRank>()
            .localData { self.localRankDataSource.fetchUserRank(scope: scope, dateType: dateType) }
            .remoteData { self.remoteRankDataSource.fetchUserSchoolRank(scope: scope, dateType: dateType) }
            .doOnNeedRefresh { self.localRankDataSource.storeUserRank(userRank: $0, scope: scope, dateType: dateType) }
            .createObservable()
    }

    func fetchUserRank(schoolId: Int, dateType: DateType) -> Single<[RankedUser]> {
        return remoteRankDataSource.fetchUserRank(
            schoolId: schoolId,
            dateType: dateType
        )
    }

    func searchUser(
        name: String,
        dateType: DateType
    ) -> Single<[User]> {
        return remoteRankDataSource.searchUser(
            name: name,
            dateType: dateType)
    }

    func searchUser(schoolId: Int, name: String, dateType: DateType) -> Single<[User]> {
        return searchUser(
            schoolId: schoolId,
            name: name,
            dateType: dateType
        )
    }
}
