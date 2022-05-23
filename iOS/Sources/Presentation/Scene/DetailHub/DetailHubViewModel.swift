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
        let dateType: Driver<DateType>
    }
    struct Output {
        let searchUserList: PublishRelay<[User]>
        let defaultUserList: PublishRelay<[RankedUser]>
        let schoolDetails: PublishRelay<SchoolDetails>
        let isJoinedClass: PublishRelay<Bool>
    }

    func transform(_ input: Input) -> Output {
        let searchUserList = PublishRelay<[User]>()
        let defaultUserList = PublishRelay<[RankedUser]>()
        let schoolDetails = PublishRelay<SchoolDetails>()
        let isJoinedClass = PublishRelay<Bool>()

        let info = Driver.combineLatest(input.name, input.dateType)

        input.name.asObservable().withLatestFrom(info).flatMap { name, type in
            self.searchUserUseCase.excute(
                name: name,
                dateType: type,
                schoolId: input.schoolId
            )
        }.subscribe(onNext: {
            searchUserList.accept($0)
        }).disposed(by: disposeBag)

        return Output(
            searchUserList: searchUserList,
            defaultUserList: defaultUserList,
            schoolDetails: schoolDetails,
            isJoinedClass: isJoinedClass
        )
    }
}
