import Foundation

import RxSwift

public class SearchSchoolUseCase {

    private let schoolRepository: SchoolRepository

    init(schoolRespository: SchoolRepository) {
        self.schoolRepository = schoolRespository
    }

    public func excute(name: String) -> Single<[SearchSchool]> {
        return schoolRepository.searchSchool(name: name)
    }
}
