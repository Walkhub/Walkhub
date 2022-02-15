import Foundation

import RxSwift

class DefaultSchoolRepository: SchoolRepository {
    func searchSchool(name: String) -> Single<[SearchSchool]> {
        return RemoteSchoolsDataSource.shared.searchSchool(name: name)
    }
}
