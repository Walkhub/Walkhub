import Foundation

import RxSwift
import RxCocoa
import Service
import RxFlow

class ActivityAnalysisViewModel: ViewModelType, Stepper {

    private let fetchCaloriesLevelUseCase: FetchCalroiesLevelUseCase
    private let fetchLiveDailyExerciseRecordUseCase: FetchLiveDailyExerciseRecordUseCase
    private let fetchExerciseAnalysisUseCase: FetchExerciseAnalysisUseCase
    private let fetchWeekStepCountChartsUseCase: FetchWeekStepCountChartsUseCase
    private let fetchMonthStepCountChartsUseCase: FetchMonthStepCountChartsUseCase

    init(
        fetchCaloriesLevelUseCase: FetchCalroiesLevelUseCase,
        fetchLiveDailyExerciseRecordUseCase: FetchLiveDailyExerciseRecordUseCase,
        fetchExerciseAnalysisUseCase: FetchExerciseAnalysisUseCase,
        fetchWeekStepCountChartsUseCase: FetchWeekStepCountChartsUseCase,
        fetchMonthStepCountChartsUseCase: FetchMonthStepCountChartsUseCase
    ) {
        self.fetchCaloriesLevelUseCase = fetchCaloriesLevelUseCase
        self.fetchLiveDailyExerciseRecordUseCase = fetchLiveDailyExerciseRecordUseCase
        self.fetchExerciseAnalysisUseCase = fetchExerciseAnalysisUseCase
        self.fetchWeekStepCountChartsUseCase = fetchWeekStepCountChartsUseCase
        self.fetchMonthStepCountChartsUseCase = fetchMonthStepCountChartsUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let getData: Driver<Void>
        let getWeekCharts: Driver<Void>
        let getMonthCharts: Driver<Void>
    }

    struct Output {
        let myCalorie: PublishRelay<CaloriesLevel>
        let dailyExerciseData: PublishRelay<DailyExerciseRecord>
        let exerciseAnalysisData: PublishRelay<ExerciseAnalysis>
        let weekCharts: PublishRelay<([Int], Int, Int)>
        let monthCharts: PublishRelay<([Int], Int, Int)>
    }

    func transform(_ input: Input) -> Output {
        let myCalorie = PublishRelay<CaloriesLevel>()
        let dailyExerciseData = PublishRelay<DailyExerciseRecord>()
        let exerciseAnalysisData = PublishRelay<ExerciseAnalysis>()
        let weekCharts = PublishRelay<([Int], Int, Int)>()
        let monthCharts = PublishRelay<([Int], Int, Int)>()

        input.getData.asObservable().flatMap {
            self.fetchCaloriesLevelUseCase.excute()
        }.subscribe(onNext: {
            myCalorie.accept($0)
        }).disposed(by: disposeBag)

        input.getData.asObservable().flatMap {
            self.fetchLiveDailyExerciseRecordUseCase.excute()
        }.subscribe(onNext: {
            dailyExerciseData.accept($0)
        }).disposed(by: disposeBag)

        input.getData.asObservable().flatMap {
            self.fetchExerciseAnalysisUseCase.excute()
        }.subscribe(onNext: {
            exerciseAnalysisData.accept($0)
        }).disposed(by: disposeBag)

        input.getData.asObservable().flatMap {
            self.fetchWeekStepCountChartsUseCase.excute()
        }.subscribe(onNext: {
            weekCharts.accept($0)
        }).disposed(by: disposeBag)

        input.getWeekCharts.asObservable().flatMap {
            self.fetchWeekStepCountChartsUseCase.excute()
        }.subscribe(onNext: {
            weekCharts.accept($0)
        }).disposed(by: disposeBag)

        input.getMonthCharts.asObservable().flatMap {
            self.fetchMonthStepCountChartsUseCase.excute()
        }.subscribe(onNext: {
            monthCharts.accept($0)
        }).disposed(by: disposeBag)

        return Output(
            myCalorie: myCalorie,
            dailyExerciseData: dailyExerciseData,
            exerciseAnalysisData: exerciseAnalysisData,
            weekCharts: weekCharts,
            monthCharts: monthCharts
        )
    }
}
