import Foundation

import Moya
import RxSwift

final class RemoteRankDataSource: RestApiRemoteDataSource<RankAPI> {

    static let shared = RemoteRankDataSource()

    private override init() { }

    func fetchSchoolRank() -> Single<MySchool> {
        return request(.fetchSchoolRank)
            .map(MySchoolRankDTO.self)
            .map { $0.toDomain() }
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
        return request(.fetchMySchoolUserRank(scope: scope, dateType: dateType))
            .map(UserRankDTO.self)
            .map { $0.toDomain() }
            .do(onError: {
                print($0)
            })
    }

    func fetchUserRank(
        schoolId: Int,
        dateType: DateType
    ) -> Single<[RankedUser]> {
        return request(.fetchAnotherSchoolUserRank(schoolId: schoolId, dateType: dateType))
            .map(DefaultSchoolUserRankListDTO.self)
            .map { $0.toDomain() }
    }

    func searchUser(
        name: String,
        dateType: DateType,
        schoolId: Int
    ) -> Single<[User]> {
        return request(.searchUser(name: name, dateType: dateType, schoolId: schoolId))
            .map(UserListDTO.self)
            .map { $0.toDomain() }
    }

}
