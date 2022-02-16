import Foundation

import RxSwift

protocol SchoolRepository {
    func searchSchool(name: String) -> Single<[SearchSchool]>
    func fetchSchoolDetails(schoolId: Int) -> Single<SchoolDetails>
}
