import Foundation

import Moya
import RxSwift

final class RemoteRankDataSource: RemoteBaseDataSource<RankAPI> {

    static let shared = RemoteRankDataSource()

    private override init() { }

    func fetchSchoolRank(dateType: DateType) -> Single<SchoolRank> {
        return request(.fetchSchoolRank(dateType: dateType))
            .map(SchoolRankDTO.self)
            .map { $0.toDomain() }
    }

    func searchSchool(name: String) -> Single<[School]> {
        return request(.searchSchool(name: name))
            .map(SchoolListDTO.self)
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
        scope: Scope,
        dateTypa: DateType,
        agencyCode: String
    ) -> Single<[User]> {
        return request(.fetchUserRank(
            scope: scope,
            dateType: dateTypa,
            agencyCode: agencyCode
        ))
            .map(UserListDTO.self)
            .map { $0.toDomain() }
    }

    func searchUser(
        name: String,
        scope: Scope,
        agencyCode: String,
        grade: Int,
        classNum: Int
    ) -> Single<[User]> {
        return request(.searchUser(
            name: name,
            scope: scope,
            agencyCode: agencyCode,
            grade: grade,
            classNum: classNum
        ))
            .map(UserListDTO.self)
            .map { $0.toDomain() }
    }

}
