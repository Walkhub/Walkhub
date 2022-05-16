import Foundation

import RxSwift
import RxCocoa
import Service
import RxFlow

class DetailHubViewModel: ViewModelType, Stepper {

    private let searchUserUseCase: SearchUserUseCase
    private let fetchUserSchoolRankUseCase: FetchUserSchoolRankUseCase
    private let fetchUserRankUseCase: FetchUserRankUseCase
    private let fetchSchoolDetailsUseCase: FetchSchoolDetailsUseCase

    init(
        searchUserUseCase: SearchUserUseCase,
        fetchUserSchoolRankUseCase: FetchUserSchoolRankUseCase,
        fetchUserRankUseCase: FetchUserRankUseCase,
        fetchSchoolDetailsUseCase: FetchSchoolDetailsUseCase
    ) {
        self.searchUserUseCase = searchUserUseCase
        self.fetchUserSchoolRankUseCase = fetchUserSchoolRankUseCase
        self.fetchUserRankUseCase = fetchUserRankUseCase
        self.fetchSchoolDetailsUseCase = fetchSchoolDetailsUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let name: Driver<String>
        let schoolId: Int
        let dateType: Driver<DateType>
        let switchOn: Driver<GroupScope>
        let isMySchool: Driver<Bool>
        let getDetails: Driver<Void>
    }

    struct Output {
        let searchUserList: PublishRelay<[User]>
        let myRank: PublishRelay<(RankedUser, Int?)>
        let userList: PublishRelay<[RankedUser]>
        let defaultUserList: PublishRelay<[RankedUser]>
        let schoolDetails: PublishRelay<SchoolDetails>
    }

    func transform(_ input: Input) -> Output {
        let searchUserList = PublishRelay<[User]>()
        let myRank = PublishRelay<(RankedUser, Int?)>()
        let userList = PublishRelay<[RankedUser]>()
        let defaultUserList = PublishRelay<[RankedUser]>()
        let schoolDetails = PublishRelay<SchoolDetails>()

        let info = Driver.combineLatest(input.name, input.dateType)
        let mySchoolType = Driver.combineLatest(input.switchOn, input.dateType)

        input.name.asObservable().withLatestFrom(info).flatMap { name, type in
            self.searchUserUseCase.excute(schoolId: input.schoolId, name: name, dateType: type)
        }.subscribe(onNext: {
            print($0)
            searchUserList.accept($0)
        }).disposed(by: disposeBag)

        input.switchOn.asObservable().withLatestFrom(mySchoolType).flatMap {
            self.fetchUserSchoolRankUseCase.excute(scope: $0, dateType: $1)
        }.subscribe(onNext: { data, walkCount in
            print(data)
            print(walkCount)
            myRank.accept((data.myRank, walkCount))
            userList.accept(data.rankList)
        }).disposed(by: disposeBag)

        input.isMySchool.asObservable().subscribe(onNext: {
            if $0 {
                input.dateType.asObservable().withLatestFrom(mySchoolType).flatMap {
                    self.fetchUserSchoolRankUseCase.excute(scope: $0, dateType: $1)
                }.subscribe(onNext: { data, walkCount in
                    print(data)
                    print(walkCount)
                    myRank.accept((data.myRank, walkCount))
                    userList.accept(data.rankList)
                }).disposed(by: self.disposeBag)
            } else {
                input.dateType.asObservable().withLatestFrom(input.dateType).flatMap {
                    self.fetchUserRankUseCase.excute(schoolId: input.schoolId, dateType: $0)
                }.subscribe(onNext: {
                    print($0)
                    defaultUserList.accept($0)
                }).disposed(by: self.disposeBag)
            }
        }).disposed(by: disposeBag)

        input.getDetails.asObservable().flatMap {
            self.fetchSchoolDetailsUseCase.excute(schoolId: input.schoolId)
        }.subscribe(onNext: {
            schoolDetails.accept($0)
        }).disposed(by: disposeBag)

        return Output(
            searchUserList: searchUserList,
            myRank: myRank,
            userList: userList,
            defaultUserList: defaultUserList,
            schoolDetails: schoolDetails
        )
    }
}
