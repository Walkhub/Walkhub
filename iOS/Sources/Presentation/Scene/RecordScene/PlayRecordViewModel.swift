import Foundation

import RxSwift
import RxCocoa
import Service
import RxFlow

class PlayRecordViewModel: ViewModelType, Stepper {

    private let fetchExerciseAnalysisUseCase: FetchExerciseAnalysisUseCase
    private let fetchMeasuringExerciseUseCase: FetchMeasuringExerciseUseCase
    private let fetchRecordExerciseUseCase: FetchRecordExerciseUseCase
    private let endExerciseUseCase: EndExerciseUseCase

    init(
        fetchExerciseAnalysisUseCase: FetchExerciseAnalysisUseCase,
        fetchMeasuringExerciseUseCase: FetchMeasuringExerciseUseCase,
        fetchRecordExerciseUseCase: FetchRecordExerciseUseCase,
        endExerciseUseCase: EndExerciseUseCase
    ) {
        self.fetchMeasuringExerciseUseCase = fetchMeasuringExerciseUseCase
        self.fetchExerciseAnalysisUseCase = fetchExerciseAnalysisUseCase
        self.fetchRecordExerciseUseCase = fetchRecordExerciseUseCase
        self.endExerciseUseCase = endExerciseUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let getData: Driver<Void>
        let endButtonDidTap: Driver<Void>
    }

    struct Output {
        let exerciseAnalysis: PublishRelay<ExerciseAnalysis>
        let dailyExericse: PublishRelay<MeasuringExerciseRecord>
        let recordExercise: PublishRelay<RecordExercise>
    }

    func transform(_ input: Input) -> Output {
        let exerciseAnalysis = PublishRelay<ExerciseAnalysis>()
        let dailyExercise = PublishRelay<MeasuringExerciseRecord>()
        let recordExercise = PublishRelay<RecordExercise>()

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

        input.getData.asObservable().flatMap {
            self.fetchRecordExerciseUseCase.excute()
        }.subscribe(onNext: {
            recordExercise.accept($0)
        }).disposed(by: disposeBag)

        input.endButtonDidTap.asObservable()
            .map { WalkhubStep.snapShotIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(
            exerciseAnalysis: exerciseAnalysis,
            dailyExericse: dailyExercise,
            recordExercise: recordExercise
        )
    }
}
