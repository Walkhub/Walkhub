import Foundation

import RxSwift

public class SearchSchoolUseCase {

    private let schoolRepository: SchoolRepository

    init(schoolRepository: SchoolRepository) {
        self.schoolRepository = schoolRepository
    }

    public func excute(name: String) -> Observable<[SearchSchool]> {
        self.schoolRepository.searchSchool(name: name)
    }
}
