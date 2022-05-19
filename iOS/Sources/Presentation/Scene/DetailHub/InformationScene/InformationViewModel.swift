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
        let getData: Driver<Void>
        let schoolId: Int
    }
    struct Output {
        let schoolDetails: PublishRelay<SchoolDetails>
        let noticeList: PublishRelay<[Notice]>
    }

    func transform(_ input: Input) -> Output {
        let schoolDetails = PublishRelay<SchoolDetails>()
        let noticeList = PublishRelay<[Notice]>()

        input.getData
            .asObservable()
            .flatMap {
                self.fetchSchoolDetailsUseCase.excute(schoolId: input.schoolId)
            }.subscribe(onNext: {
                schoolDetails.accept($0)
            }).disposed(by: disposeBag)

        input.getData
            .asObservable()
            .flatMap {
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
