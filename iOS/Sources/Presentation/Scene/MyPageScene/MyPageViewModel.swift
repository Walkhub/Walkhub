import Foundation

import RxSwift
import RxCocoa
import Service
import RxFlow

class MyPageViewModel: ViewModelType, Stepper {

    private let fetchMyPageUseCase: FetchMyPageUseCase
    private let fetchDailyExerciseUseCase: FetchLiveDailyExerciseRecordUseCase

    init(
        fetchMyPageUseCase: FetchMyPageUseCase,
        fetchDailyExerciseUseCase: FetchLiveDailyExerciseRecordUseCase
    ) {
        self.fetchMyPageUseCase = fetchMyPageUseCase
        self.fetchDailyExerciseUseCase = fetchDailyExerciseUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let getData: Driver<Void>
    }

    struct Output {
        let myProfile: PublishRelay<UserProfile>
        let dailyExercise: PublishRelay<DailyExerciseRecord>
    }

    func transform(_ input: Input) -> Output {
        let myProfile = PublishRelay<UserProfile>()
        let dailyExercise = PublishRelay<DailyExerciseRecord>()

        input.getData.asObservable().flatMap {
            self.fetchMyPageUseCase.excute()
        }.subscribe(onNext: {
            myProfile.accept($0)
        }).disposed(by: disposeBag)

        input.getData.asObservable().flatMap {
            self.fetchDailyExerciseUseCase.excute()
        }.subscribe(onNext: {
            dailyExercise.accept($0)
        }).disposed(by: disposeBag)

        return Output(myProfile: myProfile, dailyExercise: dailyExercise)
    }
}
