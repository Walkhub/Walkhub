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

    func fetchSchoolDetails(schoolId: Int) -> Single<SchoolDetails> {
        return request(.fetchSchoolDetails(schoolId: schoolId))
            .map(SchoolDetailsDTO.self)
            .map { $0.toDomain() }
    }
}
