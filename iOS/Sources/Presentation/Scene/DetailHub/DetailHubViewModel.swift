import Foundation

import RxSwift
import RxCocoa
import Service

class DetailHubViewModel: ViewModelType {

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

    struct Input {
        let name: Driver<String>
        let schoolId: Driver<Int>
        let dateType: Driver<DateType>
        let switchOn: Driver<GroupScope>
        let isMySchool: Driver<Bool>
        let getDetails: Driver<Void>
    }

    struct Output {
        let searchUserList: PublishRelay<[User]>
        let myRank: PublishRelay<(User, Int?)>
        let userList: PublishRelay<[User]>
        let schoolDetails: PublishRelay<SchoolDetails>
    }

    func transform(_ input: Input) -> Output {
        let searchUserList = PublishRelay<[User]>()
        let myRank = PublishRelay<(User, Int?)>()
        let userList = PublishRelay<[User]>()
        let schoolDetails = PublishRelay<SchoolDetails>()

        let info = Driver.combineLatest(input.name, input.schoolId, input.dateType)
        let mySchoolType = Driver.combineLatest(input.switchOn, input.dateType)
        let anotherSchoolType = Driver.combineLatest(input.schoolId, input.dateType)

        input.name.asObservable().withLatestFrom(info).flatMap { name, id, type in
            self.searchUserUseCase.excute(schoolId: id, name: name, dateType: type)
        }.subscribe(onNext: {
            searchUserList.accept($0)
        }).disposed(by: disposeBag)

        input.switchOn.asObservable().withLatestFrom(mySchoolType).flatMap {
            self.fetchUserSchoolRankUseCase.excute(scope: $0, dateType: $1)
        }.subscribe(onNext: { data, walkCount in
            myRank.accept((data.myRank, walkCount))
            userList.accept(data.rankList)
        }).disposed(by: disposeBag)

        input.isMySchool.asObservable().subscribe(onNext: {
            if $0 {
                input.dateType.asObservable().withLatestFrom(mySchoolType).flatMap {
                    self.fetchUserSchoolRankUseCase.excute(scope: $0, dateType: $1)
                }.subscribe(onNext: { data, walkCount in
                    myRank.accept((data.myRank, walkCount))
                    userList.accept(data.rankList)
                }).disposed(by: self.disposeBag)
            } else {
                input.dateType.asObservable().withLatestFrom(anotherSchoolType).flatMap {
                    self.fetchUserRankUseCase.excute(schoolId: $0, dateType: $1)
                }.subscribe(onNext: {
                    userList.accept($0)
                }).disposed(by: self.disposeBag)
            }
        }).disposed(by: disposeBag)

        input.getDetails.asObservable().withLatestFrom(input.schoolId).flatMap {
            self.fetchSchoolDetailsUseCase.excute(schoolId: $0)
        }.subscribe(onNext: {
            schoolDetails.accept($0)
        }).disposed(by: disposeBag)

        return Output(
            searchUserList: searchUserList,
            myRank: myRank,
            userList: userList,
            schoolDetails: schoolDetails
        )
    }
}
