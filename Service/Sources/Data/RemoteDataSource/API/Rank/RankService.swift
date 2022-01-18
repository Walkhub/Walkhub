import Foundation

import Moya
import RxSwift

final class RankService: BaseService<RankAPI> {
    func schoolRankInquriy(dateType: String) -> Single<Response> {
        return request(.schoolRankInquriy(dateType: dateType))
    }
    func searchSchool(name: String) -> Single<Response> {
        return request(.searchSchool(name: name))
    }
    func userRankInquriy(
        scope: String,
        dateTypa: String,
        sort: String,
        agencyCode: String
    ) -> Single<Response> {
        return request(.userRankInquriy(
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
