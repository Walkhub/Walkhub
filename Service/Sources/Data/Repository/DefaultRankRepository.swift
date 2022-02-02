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

    func searchSchool(name: String) -> Single<[School]> {
        return RemoteRankDataSource.shared.searchSchool(name: name)
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

    func fetchUserRank(
        scope: Scope,
        dateTypa: DateType,
        agencyCode: String
    ) -> Single<[User]> {
        return RemoteRankDataSource.shared.fetchUserRank(
            scope: scope,
            dateTypa: dateTypa,
            agencyCode: agencyCode
        )
    }

    func searchUser(
        name: String,
        scope: Scope,
        agencyCode: String,
        grade: Int,
        classNum: Int
    ) -> Single<[User]> {
        return RemoteRankDataSource.shared.searchUser(
            name: name,
            scope: scope,
            agencyCode: agencyCode,
            grade: grade,
            classNum: classNum
        )
    }

}
