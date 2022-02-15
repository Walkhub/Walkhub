import Foundation

import RxSwift

class DefaultRankRepository: RankRepository {

    func fetchSchoolRank(dateType: DateType) -> Observable<SchoolRank> {
        return OfflineCacheUtil<SchoolRank>()
            .remoteData { RemoteRankDataSource.shared.fetchSchoolRank(dateType: dateType) }
            .localData { LocalRankDataSource.shared.fetchSchoolRank(dateType: dateType) }
            .doOnNeedRefresh { LocalRankDataSource.shared.storeSchoolRank(schoolRank: $0, dateType: dateType) }
            .createObservable()
    }

    func fetchUserSchoolRank(
        scope: Scope,
        dateType: DateType
    ) -> Observable<UserRank> {
        return OfflineCacheUtil<UserRank>()
            .remoteData {
                RemoteRankDataSource.shared.fetchUserSchoolRank(
                    scope: scope,
                    dateType: dateType
                )
            }
            .localData {
                LocalRankDataSource.shared.fetchUserRank(
                    scope: scope,
                    dateType: dateType
                )
            }
            .doOnNeedRefresh {
                LocalRankDataSource.shared.storeUserRank(
                    userRank: $0,
                    scope: scope,
                    dateType: dateType
                )
            }
            .createObservable()
    }

    func searchSchool(name: String, dateType: DateType) -> Single<[SearchSchool]> {
        return RemoteRankDataSource.shared.searchSchool(
            name: name,
            dateType: dateType
        )
    }

    func fetchUserRank(schoolId: Int, dateType: DateType) -> Single<[User]> {
        return RemoteRankDataSource.shared.fetchUserRank(
            schoolId: schoolId,
            dateType: dateType
        )
    }

    func searchUser(schoolId: Int, name: String, dateType: DateType) -> Single<[User]> {
        return searchUser(
            schoolId: schoolId,
            name: name,
            dateType: dateType
        )
    }
}
