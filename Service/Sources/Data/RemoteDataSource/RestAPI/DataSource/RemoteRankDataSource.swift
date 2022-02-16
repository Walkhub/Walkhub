import Foundation

import Moya
import RxSwift

final class RemoteRankDataSource: RestApiRemoteDataSource<RankAPI> {

    static let shared = RemoteRankDataSource()

    private override init() { }

    func fetchSchoolRank(dateType: DateType) -> Single<SchoolRank> {
        return request(.fetchSchoolRank(dateType: dateType))
            .map(SchoolRankDTO.self)
            .map { $0.toDomain() }
    }

    func searchSchool(name: String, dateType: DateType) -> Single<[SearchSchoolRank]> {
        return request(.searchSchool(name: name, dateType: dateType))
            .map(SearchSchoolRankListDTO.self)
            .map { $0.toDomain() }
    }

    func fetchUserSchoolRank(
        scope: Scope,
        dateType: DateType
    ) -> Single<UserRank> {
        return request(.fetchUserSchoolRank(scope: scope, dateType: dateType))
            .map(UserRankDTO.self)
            .map { $0.toDomain() }
    }

    func fetchUserRank(
        schoolId: Int,
        dateType: DateType
    ) -> Single<[User]> {
        return request(.fetchUserRank(schoolId: schoolId, dateType: dateType))
            .map(UserListDTO.self)
            .map { $0.toDomain() }
    }

    func searchUser(
        name: String,
        dateType: DateType
    ) -> Single<[User]> {
        return request(.searchUser(name: name, dateType: dateType))
            .map(UserListDTO.self)
            .map { $0.toDomain() }
    }

}
