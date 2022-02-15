import Foundation

import Moya
import RxSwift

final class RemoteSchoolsDataSource: RestApiRemoteDataSource<SchoolAPI> {

    static let shared = RemoteSchoolsDataSource()

    func searchSchool(name: String) -> Single<[SearchSchool]> {
        return request(.searchSchool(name: name))
            .map(SearchSchoolListDTO.self)
            .map { $0.toDomain() }
    }
}
