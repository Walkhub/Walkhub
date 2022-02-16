import Foundation

import RxSwift

public class FetchSchoolDetailsUseCase {

    private let schoolRepository: SchoolRepository

    init(schoolRepository: SchoolRepository) {
        self.schoolRepository = schoolRepository
    }

    public func excute(schoolId: Int) -> Single<SchoolDetails> {
        return self.schoolRepository.fetchSchoolDetails(schoolId: schoolId)
    }
}
