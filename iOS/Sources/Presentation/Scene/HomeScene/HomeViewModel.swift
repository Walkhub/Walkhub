import Foundation

import RxCocoa
import RxFlow
import RxSwift
import Service

class HomeViewModel: ViewModelType, Stepper {

    private let fetchCalroiesLevelUseCase: FetchCalroiesLevelUseCase
    private let fetchLiveDailyExerciseRecordUseCase: FetchLiveDailyExerciseRecordUseCase
    private let fetchExercisesAnalysisUseCase: FetchExerciseAnalysisUseCase
    private let fetchRankPreviewUseCase: FetchRankPreviewUseCase

    init(
        fetchCaloriesLevelUseCase: FetchCalroiesLevelUseCase,
        fetchLiveDailyExerciseRecordUseCase: FetchLiveDailyExerciseRecordUseCase,
        fetchExercisesAnalysisUseCase: FetchExerciseAnalysisUseCase,
        fetchRankPreviewUseCase: FetchRankPreviewUseCase
    ) {
        self.fetchCalroiesLevelUseCase = fetchCaloriesLevelUseCase
        self.fetchLiveDailyExerciseRecordUseCase = fetchLiveDailyExerciseRecordUseCase
        self.fetchExercisesAnalysisUseCase = fetchExercisesAnalysisUseCase
        self.fetchRankPreviewUseCase = fetchRankPreviewUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let getMainData: Driver<Void>
    }

    struct Output {
        let caloriesData: PublishRelay<CaloriesLevel>
        let mainData: PublishRelay<DailyExerciseRecord>
        let goalData: PublishRelay<ExerciseAnalysis>
        let rankList: PublishRelay<[User]>
    }

    func transform(_ input: Input) -> Output {
        let caloriesData = PublishRelay<CaloriesLevel>()
        let mainData = PublishRelay<DailyExerciseRecord>()
        let goalData = PublishRelay<ExerciseAnalysis>()
        let rankList = PublishRelay<[User]>()

        input.getMainData.asObservable().flatMap {
            self.fetchCalroiesLevelUseCase.excute()
        }.subscribe(onNext: {
            print("1: \($0)")
            caloriesData.accept($0)
        }).disposed(by: disposeBag)

        input.getMainData.asObservable().flatMap {
            self.fetchLiveDailyExerciseRecordUseCase.excute()
        }.subscribe(onNext: {
            print("2: \($0)")
            mainData.accept($0)
        }).disposed(by: disposeBag)

        input.getMainData.asObservable().flatMap {
            self.fetchExercisesAnalysisUseCase.excute()
        }.subscribe(onNext: {
            print("3: \($0)")
            goalData.accept($0)
        }).disposed(by: disposeBag)

        input.getMainData.asObservable().flatMap {
            self.fetchRankPreviewUseCase.excute()
        }.subscribe(onNext: {
            print("4: \($0)")
            rankList.accept($0)
        }).disposed(by: disposeBag)

        return Output(
            caloriesData: caloriesData,
            mainData: mainData,
            goalData: goalData,
            rankList: rankList
        )
    }
}
