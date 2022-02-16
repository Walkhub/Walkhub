import Foundation

import RxSwift

class DefaultSchoolRepository: SchoolRepository {

    private let remoteSchoolsDataSource = RemoteSchoolsDataSource.shared
    func searchSchool(name: String) -> Single<[SearchSchool]> {
        return remoteSchoolsDataSource.searchSchool(name: name)
    }

    func fetchSchoolDetails(schoolId: Int) -> Single<SchoolDetails> {
        return remoteSchoolsDataSource.fetchSchoolDetails(schoolId: schoolId)
    }
}
