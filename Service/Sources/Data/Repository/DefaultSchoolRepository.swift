import Foundation

import RxSwift

class DefaultSchoolRepository: SchoolRepository {

    private let remoteSchoolsDataSource = RemoteSchoolsDataSource.shared
    func searchSchool(name: String) -> Observable<[SearchSchool]> {
        return remoteSchoolsDataSource.searchSchool(name: name)
            .asObservable()
    }

    func fetchSchoolDetails(schoolId: Int) -> Observable<SchoolDetails> {
        return remoteSchoolsDataSource.fetchSchoolDetails(schoolId: schoolId)
    }
}
