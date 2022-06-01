import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class InformationViewModel: ViewModelType, Stepper {

    private let fetchSchoolDetailsUseCase: FetchSchoolDetailsUseCase
    private let fetchNoticeUseCase: FetchNoticeUseCase

    init(
        fetchSchoolDetailsUseCase: FetchSchoolDetailsUseCase,
        fetchNoticeUseCase: FetchNoticeUseCase
    ) {
        self.fetchSchoolDetailsUseCase = fetchSchoolDetailsUseCase
        self.fetchNoticeUseCase = fetchNoticeUseCase
    }

    var steps = PublishRelay<Step>()
    private var disposeBag = DisposeBag()

    struct Input {
        let schoolId: Driver<Int>
    }
    struct Output {
        let schoolDetails: PublishRelay<SchoolDetails>
        let noticeList: PublishRelay<[Notice]>
    }

    func transform(_ input: Input) -> Output {
        let schoolDetails = PublishRelay<SchoolDetails>()
        let noticeList = PublishRelay<[Notice]>()

        input.schoolId
            .asObservable()
            .flatMap {
                self.fetchSchoolDetailsUseCase.excute(schoolId: $0)
            }.subscribe(onNext: {
                schoolDetails.accept($0)
            }).disposed(by: disposeBag)

        input.schoolId
            .asObservable()
            .flatMap { _ in
                self.fetchNoticeUseCase.excute()
            }.subscribe(onNext: {
                noticeList.accept($0)
            }).disposed(by: disposeBag)

        return Output(
            schoolDetails: schoolDetails,
            noticeList: noticeList
        )
    }
}
