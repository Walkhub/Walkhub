import Foundation

import RxSwift
import RxCocoa
import Service
import RxFlow

class DetailHubViewModel: ViewModelType, Stepper {

    private let searchUserUseCase: SearchUserUseCase
    private let fetchAnotherSchoolUserRankUseCase: FetchAnotherSchoolUserRankUseCase
    private let fetchMySchoolUserRankUseCase: FetchMySchoolUserRankUseCase
    private let fetchSchoolDetailsUseCase: FetchSchoolDetailsUseCase

    init(
        searchUserUseCase: SearchUserUseCase,
        fetchAnotherSchoolUserRankUseCase: FetchAnotherSchoolUserRankUseCase,
        fetchMySchoolUserRankUseCase: FetchMySchoolUserRankUseCase,
        fetchSchoolDetailsUseCase: FetchSchoolDetailsUseCase
    ) {
        self.searchUserUseCase = searchUserUseCase
        self.fetchAnotherSchoolUserRankUseCase = fetchAnotherSchoolUserRankUseCase
        self.fetchMySchoolUserRankUseCase = fetchMySchoolUserRankUseCase
        self.fetchSchoolDetailsUseCase = fetchSchoolDetailsUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let name: Driver<String>
        let schoolId: Int?
        let dateType: Driver<DateType>
        let switchOn: Driver<GroupScope>
        let getRankData: Driver<Void>
    }
    struct Output {
        let searchUserList: PublishRelay<[User]>
        let myRank: PublishRelay<(RankedUser, Int?)>
        let userList: PublishRelay<[RankedUser]>
        let defaultUserList: PublishRelay<[RankedUser]>
        let schoolDetails: PublishRelay<SchoolDetails>
        let isJoinedClass: PublishRelay<Bool>
    }

    func transform(_ input: Input) -> Output {
        let searchUserList = PublishRelay<[User]>()
        let myRank = PublishRelay<(RankedUser, Int?)>()
        let userList = PublishRelay<[RankedUser]>()
        let defaultUserList = PublishRelay<[RankedUser]>()
        let schoolDetails = PublishRelay<SchoolDetails>()
        let isJoinedClass = PublishRelay<Bool>()

        let info = Driver.combineLatest(input.name, input.dateType)
        let mySchoolType = Driver.combineLatest(input.switchOn, input.dateType)

        input.name.asObservable().withLatestFrom(info).flatMap { name, type in
            self.searchUserUseCase.excute(
                name: name,
                dateType: type,
                schoolId: input.schoolId!
            )
        }.subscribe(onNext: {
            searchUserList.accept($0)
        }).disposed(by: disposeBag)

        input.switchOn.asObservable().withLatestFrom(mySchoolType).flatMap {
            self.fetchMySchoolUserRankUseCase.excute(scope: $0, dateType: $1)
        }.subscribe(onNext: {data, walkCount in
            myRank.accept((data.myRank, walkCount))
            userList.accept(data.rankList)
            isJoinedClass.accept(data.isJoinedClass)
        }).disposed(by: disposeBag)

        input.getRankData.asObservable().subscribe(onNext: {_ in
            if input.schoolId == nil {
                input.dateType.asObservable().withLatestFrom(mySchoolType).flatMap {
                    self.fetchMySchoolUserRankUseCase.excute(scope: $0, dateType: $1)
                }.subscribe(onNext: { data, walkCount in
                    myRank.accept((data.myRank, walkCount))
                    userList.accept(data.rankList)
                    isJoinedClass.accept(data.isJoinedClass)
                }).disposed(by: self.disposeBag)
            } else {
                input.dateType.asObservable().withLatestFrom(input.dateType).flatMap {
                    self.fetchAnotherSchoolUserRankUseCase.excute(schoolId: input.schoolId!, dateType: $0)
                }.subscribe(onNext: {
                    defaultUserList.accept($0)
                }).disposed(by: self.disposeBag)
            }
        }).disposed(by: disposeBag)

        return Output(
            searchUserList: searchUserList,
            myRank: myRank,
            userList: userList,
            defaultUserList: defaultUserList,
            schoolDetails: schoolDetails,
            isJoinedClass: isJoinedClass
        )
    }
}
