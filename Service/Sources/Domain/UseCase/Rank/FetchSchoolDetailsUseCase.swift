import Foundation

import RxSwift

public class FetchSchoolDetailsUseCase {

    private let schoolRepository: SchoolRepository

    init(schoolRepository: SchoolRepository) {
        self.schoolRepository = schoolRepository
    }

    public func excute(schoolId: Int) -> Observable<SchoolDetails> {
        return self.schoolRepository.fetchSchoolDetails(schoolId: schoolId)
    }
}
