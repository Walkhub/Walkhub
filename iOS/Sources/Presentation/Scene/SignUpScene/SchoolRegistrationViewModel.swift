import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class SchoolRegistrationViewModel: ViewModelType, Stepper {

    private let searchSchoolUseCase: SearchSchoolUseCase

    init(searchSchoolUseCase: SearchSchoolUseCase) {
        self.searchSchoolUseCase = searchSchoolUseCase
    }

    struct Input {
        let searchSchool: Driver<String>
        let cellTap: Driver<IndexPath>
        let continueButtonDidTap: Driver<Void>
    }

    struct Output {
        let schoolList: BehaviorRelay<[SearchSchool]>
        let schoolId: PublishRelay<Int>
    }

    var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let schoolList = BehaviorRelay<[SearchSchool]>(value: [])
        let schoolId = PublishRelay<Int>()

        input.searchSchool
            .asObservable()
            .withLatestFrom(input.searchSchool)
            .flatMap {
                self.searchSchoolUseCase.excute(name: $0)
            }.subscribe(onNext: {
                schoolList.accept($0)
            }).disposed(by: disposeBag)

        input.cellTap
            .asObservable()
            .subscribe(onNext: { index in
                let value = schoolList.value
                schoolId.accept(value[index.row].id)
            }).disposed(by: disposeBag)

        input.continueButtonDidTap
            .asObservable()
            .map { WalkhubStep.setSchoolIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(schoolList: schoolList, schoolId: schoolId)
    }
}
