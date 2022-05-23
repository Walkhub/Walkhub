import Foundation

import RxCocoa
import RxFlow
import RxSwift
import Service

class HubViewModel: ViewModelType, Stepper {

    private let fetchSchoolUseCase: FetchSchoolRankUseCase
    private let searchSchoolRankUseCase: SearchSchoolRankUseCase
    private let searchSchoolUseCase: SearchSchoolUseCase

    init(
        fetchSchoolUseCase: FetchSchoolRankUseCase,
        searchSchoolRankUseCase: SearchSchoolRankUseCase,
        searchSchoolUseCase: SearchSchoolUseCase
    ) {
        self.fetchSchoolUseCase = fetchSchoolUseCase
        self.searchSchoolRankUseCase = searchSchoolRankUseCase
        self.searchSchoolUseCase = searchSchoolUseCase
    }

    private var disposeBag = DisposeBag()
    private var mySchoolId: Int = .init()
    private var schoolName: String = .init()
    var steps = PublishRelay<Step>()

    struct Input {
        let dateType: Driver<DateType>
        let name: Driver<String>
        let mySchoolViewDidTap: Driver<Void>
        let rankCellDidSelected: Driver<IndexPath>
        let searchCelDidSelected: Driver<IndexPath>
    }

    struct Output {
        let mySchoolRank: PublishRelay<MySchool>
        let schoolRank: BehaviorRelay<[School]>
        let searchSchoolList: BehaviorRelay<[SearchSchool]>
    }

    func transform(_ input: Input) -> Output {
        let mySchoolRank = PublishRelay<MySchool>()
        let schoolRank = BehaviorRelay<[School]>(value: [])
        let searchSchoolList = BehaviorRelay<[SearchSchool]>(value: [])

        input.dateType.asObservable()
            .flatMap { _ in
                self.fetchSchoolUseCase.excute()
            }.subscribe(onNext: {
                mySchoolRank.accept($0)
                self.mySchoolId = $0.id
                self.schoolName = $0.name
            }).disposed(by: disposeBag)

        input.dateType.asObservable()
            .flatMap {
                self.searchSchoolRankUseCase.excute(name: nil, dateType: $0)
            }.subscribe(onNext: {
                schoolRank.accept($0)
            }).disposed(by: disposeBag)

        input.name.asObservable()
            .flatMap {
                self.searchSchoolUseCase.excute(name: $0)
            }.subscribe(onNext: {
                searchSchoolList.accept($0)
            }).disposed(by: disposeBag)

        input.mySchoolViewDidTap.asObservable()
            .map { WalkhubStep.detailHubIsRequired(
                self.mySchoolId,
                self.schoolName,
                true
            ) }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.rankCellDidSelected.asObservable()
            .map { index -> (Int, String) in
                let value = schoolRank.value
                return (value[index.row].schoolId, value[index.row].name)
            }.flatMap { data -> Single<Step> in
                let isMySchool = data.0 == self.mySchoolId
                return Single.just(WalkhubStep.detailHubIsRequired(data.0, data.1, isMySchool))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        input.searchCelDidSelected.asObservable()
            .map { index -> (Int, String) in
                let value = searchSchoolList.value
                return (value[index.row].id, value[index.row].name)
            }.flatMap { data -> Single<Step> in
                let isMyschool = data.0 == self.mySchoolId
                return Single.just(WalkhubStep.detailHubIsRequired(data.0, data.1, isMyschool))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        return Output(
            mySchoolRank: mySchoolRank,
            schoolRank: schoolRank,
            searchSchoolList: searchSchoolList
        )
    }
}
