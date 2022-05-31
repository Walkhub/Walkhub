import Foundation

import RxSwift
import RxCocoa
import Service
import RxFlow

class DetailHubViewModel: ViewModelType, Stepper {

    private let searchUserUseCase: SearchUserUseCase
    private let fetchAnotherSchoolUserRankUseCase: FetchAnotherSchoolUserRankUseCase
    private let fetchSchoolDetailsUseCase: FetchSchoolDetailsUseCase

    init(
        searchUserUseCase: SearchUserUseCase,
        fetchAnotherSchoolUserRankUseCase: FetchAnotherSchoolUserRankUseCase,
        fetchMySchoolUserRankUseCase: FetchMySchoolUserRankUseCase,
        fetchSchoolDetailsUseCase: FetchSchoolDetailsUseCase
    ) {
        self.searchUserUseCase = searchUserUseCase
        self.fetchAnotherSchoolUserRankUseCase = fetchAnotherSchoolUserRankUseCase
        self.fetchSchoolDetailsUseCase = fetchSchoolDetailsUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let name: Driver<String>
        let schoolId: Int
        let dateType: BehaviorRelay<DateType>
    }
    struct Output {
        let searchUserList: PublishRelay<[User]>
    }

    func transform(_ input: Input) -> Output {
        let searchUserList = PublishRelay<[User]>()

        let info = Driver.combineLatest(input.name, input.dateType.asDriver())

        input.name
            .asObservable()
            .debounce(.milliseconds(200), scheduler: MainScheduler.asyncInstance)
            .withLatestFrom(info).flatMap { name, type -> Observable<[User]> in
                return self.searchUserUseCase.excute(
                    name: name,
                    dateType: type,
                    schoolId: input.schoolId
                )
            }.subscribe(onNext: {
                searchUserList.accept($0)
            }).disposed(by: disposeBag)

        return Output(
            searchUserList: searchUserList
        )
    }
}
