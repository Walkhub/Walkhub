import Foundation

import RxSwift

protocol SchoolRepository {
    func searchSchool(name: String) -> Observable<[SearchSchool]>
    func fetchSchoolDetails(schoolId: Int) -> Observable<SchoolDetails>
}
