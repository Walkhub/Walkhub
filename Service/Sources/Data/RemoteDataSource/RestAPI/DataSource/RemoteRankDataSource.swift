import Foundation

import Moya
import RxSwift

final class RemoteRankDataSource: RestApiRemoteDataSource<RankAPI> {

    static let shared = RemoteRankDataSource()

    private override init() { }

    func fetchSchoolRank(dateType: DateType) -> Single<MySchool> {
        return request(.fetchSchoolRank(dateType: dateType))
            .map(MySchoolRankDTO.self)
            .map { $0.mySchoolRank.toDomain() }
    }

    func searchSchool(name: String?, dateType: DateType) -> Single<[School]> {
        return request(.searchSchoolRank(name: name, dateType: dateType))
            .map(SearchSchoolRankListDTO.self)
            .map { $0.toDomain() }
    }

    func fetchUserSchoolRank(
        scope: GroupScope,
        dateType: DateType
    ) -> Single<UserRank> {
        return request(.fetchUserSchoolRank(scope: scope, dateType: dateType))
            .map(UserRankDTO.self)
            .map { $0.toDomain() }
    }

    func fetchUserRank(
        schoolId: Int,
        dateType: DateType
    ) -> Single<[RankedUser]> {
        return request(.fetchUserRank(schoolId: schoolId, dateType: dateType))
            .map(DefaultSchoolUserRankListDTO.self)
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
