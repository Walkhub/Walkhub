import Foundation

import Moya
import RxSwift

final class RemoteRankDataSource: RemoteBaseDataSource<RankAPI> {

    static let shared = RemoteRankDataSource()

    private override init() { }

    func fetchSchoolRank(dateType: String) -> Single<Response> {
        return request(.fetchSchoolRank(dateType: dateType))
    }

    func searchSchool(name: String) -> Single<Response> {
        return request(.searchSchool(name: name))
    }

    func fetchUserRank(
        scope: String,
        dateTypa: String,
        sort: String,
        agencyCode: String
    ) -> Single<Response> {
        return request(.fetchUserRank(
            scope: scope,
            dateType: dateTypa,
            sort: sort,
            agencyCode: agencyCode
        ))
    }

    func searchUser(
        name: String,
        scope: String,
        agencyCode: String,
        grade: Int,
        classNum: Int
    ) -> Single<Response> {
        return request(.searchUser(
            name: name,
            scope: scope,
            agencyCode: agencyCode,
            grade: grade,
            classNum: classNum
        ))
    }

}
