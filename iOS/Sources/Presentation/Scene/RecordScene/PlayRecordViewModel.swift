import Foundation

import RxSwift
import RxCocoa
import Service

class PlayRecordViewModel: ViewModelType {

    private let fetchExerciseAnalysisUseCase: FetchExerciseAnalysisUseCase
    private let fetchMeasuringExerciseUseCase: FetchMeasuringExerciseUseCase

    init(
        fetchExerciseAnalysisUseCase: FetchExerciseAnalysisUseCase,
        fetchMeasuringExerciseUseCase: FetchMeasuringExerciseUseCase
    ) {
        self.fetchMeasuringExerciseUseCase = fetchMeasuringExerciseUseCase
        self.fetchExerciseAnalysisUseCase = fetchExerciseAnalysisUseCase
    }

    private var disposeBag = DisposeBag()
    struct Input {
        let getData: Driver<Void>
    }

    struct Output {
        let exerciseAnalysis: PublishRelay<ExerciseAnalysis>
        let dailyExericse: PublishRelay<MeasuringExerciseRecord>
    }

    func transform(_ input: Input) -> Output {
        let exerciseAnalysis = PublishRelay<ExerciseAnalysis>()
        let dailyExercise = PublishRelay<MeasuringExerciseRecord>()

        input.getData.asObservable().flatMap {
            self.fetchExerciseAnalysisUseCase.excute()
        }.subscribe(onNext: {
            exerciseAnalysis.accept($0)
        }).disposed(by: disposeBag)

        input.getData.asObservable().flatMap {
            self.fetchMeasuringExerciseUseCase.excute()
        }.subscribe(onNext: {
            dailyExercise.accept($0)
        }).disposed(by: disposeBag)

        return Output(
            exerciseAnalysis: exerciseAnalysis,
            dailyExericse: dailyExercise)
    }
}
