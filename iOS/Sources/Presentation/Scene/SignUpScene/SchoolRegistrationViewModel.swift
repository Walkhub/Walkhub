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
        let name: String
        let phoneNumber: String
        let authCode: String
        let id: String
        let password: String
        let searchSchool: Driver<String>
        let cellTap: Driver<IndexPath>
        let continueButtonDidTap: Driver<Void>
    }

    struct Output {
        let schoolList: BehaviorRelay<[SearchSchool]>
        let schoolId: PublishRelay<Int>
        let schoolInfo: PublishRelay<SearchSchool>
    }

    var steps = PublishRelay<Step>()
    private let disposeBag = DisposeBag()
    private var schoolId = Int()

    func transform(_ input: Input) -> Output {
        let schoolList = BehaviorRelay<[SearchSchool]>(value: [])
        let schoolInfo = PublishRelay<SearchSchool>()
        let schoolId = PublishRelay<Int>()

        input.searchSchool
            .asObservable()
            .debounce(
                .milliseconds(200),
                scheduler: MainScheduler.asyncInstance
            ).flatMap {
                self.searchSchoolUseCase.excute(name: $0)
            }.subscribe(onNext: {
                schoolList.accept($0)
            }).disposed(by: disposeBag)

        input.cellTap
            .asObservable()
            .subscribe(onNext: { index in
                let value = schoolList.value
                schoolId.accept(value[index.row].id)
                schoolInfo.accept(value[index.row])
                self.schoolId = value[index.row].id
            }).disposed(by: disposeBag)

        input.continueButtonDidTap
            .asObservable()
            .map { WalkhubStep.agreeIsRequired(
                name: input.name,
                phoneNumber: input.phoneNumber,
                authCode: input.authCode,
                id: input.id,
                password: input.password,
                schoolId: self.schoolId
            )}.bind(to: steps)
            .disposed(by: disposeBag)

        return Output(schoolList: schoolList, schoolId: schoolId, schoolInfo: schoolInfo)
    }
}
