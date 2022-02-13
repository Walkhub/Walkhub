import Foundation

import HealthKit
import RxSwift

public class DefaultExercisesRepository: ExercisesRepository {

    public init() { }

    private let healthKitDataSource = HealthKitDataSource.shared
    private let localExercisesDataSource = LocalExerciseDataSource.shared
    private let remoteExercisesDataSource = RemoteExercisesDataSource.shared
    private let userDefaultsDataSource = UserDefaultsDataSource.shared

    private var exerciseId: Int?
    private var measuringStartAt: Date?
    private var isMeasuring: Bool {
        get { exerciseId != nil }
        set(newValue) {
            if !newValue {
                exerciseId = nil
                measuringStartAt = nil
            }
        }
    }

    func fetchLiveDailyExerciseRecord() -> Observable<DailyExerciseRecord> {
        healthKitDataSource.observeExerciseRecordChangeSignal()
            .flatMap { self.fetchDailyExerciseRecord() }
    }

    func fetchLiveMeasuringExerciseRecord() -> Observable<MeasuringExerciseRecord> {
        healthKitDataSource.observeExerciseRecordChangeSignal()
            .flatMap { self.fetchMeasuringExerciseRecord() }
    }

    func synchronizeDailyExerciseRecord() -> Completable {
        fetchDailyExerciseRecord()
            .flatMapCompletable {
                self.remoteExercisesDataSource.saveDailyExsercises(
                    date: Date(),
                    distance: $0.walkingRunningDistanceAsMeter,
                    walkCount: $0.stepCount,
                    calorie: $0.burnedKilocalories
                )
            }
    }

    func fetchExerciseAnalysis() -> Observable<ExerciseAnalysis> {
        Observable.combineLatest(
            OfflineCacheUtil<[Int]>()
                .localData { self.localExercisesDataSource.fetchWalkCountRecordList() }
                .remoteData { self.remoteExercisesDataSource.fetchExerciseAnalysis().map { $0.walkCountList } }
                .doOnNeedRefresh { self.localExercisesDataSource.storeWalkCountRecordList($0) }
                .createObservable(),
            fetchLiveDailyExerciseRecord()
        ) {
            let walkCountList: [Int] = $0.dropLast()+[$1.stepCount]
            return ExerciseAnalysis(
                walkCountList: walkCountList,
                dailyWalkCountGoal: 0,
                walkCount: $1.stepCount,
                calorie: $1.burnedKilocalories,
                distane: $1.walkingRunningDistanceAsMeter,
                walkTime: $1.walkingRunningTimeAsSecond
            )
        }
    }

    func fetchMeasuredExercises() -> Observable<[MeasuredExercise]> {
        OfflineCacheUtil<[MeasuredExercise]>()
            .localData { self.localExercisesDataSource.fetchMeasuredExercises() }
            .remoteData { self.remoteExercisesDataSource.fetchMeasuredExercises() }
            .doOnNeedRefresh { self.localExercisesDataSource.storeMeasuredExercises($0) }
            .createObservable()
    }

    func startMeasuring(goal: Int, goalType: MeasuringGoalType) -> Completable {
        remoteExercisesDataSource.startMeasuring(goal: goal, goalType: goalType)
            .do(onSuccess: { [weak self] exerciseId in
                self?.exerciseId = exerciseId
                self?.measuringStartAt = Date()
            }).asCompletable()
    }

    func finishMeasuring(imageUrlString: String?) -> Completable {
        fetchMeasuringExerciseRecord()
            .flatMapCompletable {
                self.remoteExercisesDataSource.finishMeasuring(
                    exercisesId: self.exerciseId!,
                    walkCount: $0.stepCount,
                    distance: Int($0.walkingRunningDistanceAsMeter),
                    imageUrlString: imageUrlString
                )
            }.do(onCompleted: { [weak self] in
                self?.isMeasuring = false
            })
    }

}

// MARK: - Fetch Data Form HealthKit
extension DefaultExercisesRepository {

    // MARK: ExerciseRecord
    func fetchDailyExerciseRecord() -> Single<DailyExerciseRecord> {
        return Single<DailyExerciseRecord>.zip(
            fetchDailyStepCount(),
            fetchDailyWalkingRunningTimeAsSecond(),
            fetchDailyWalkingRunningDistanceAsMeter(),
            fetchDailyBurnedKilocalories()
        ) { .init(
            stepCount: $0,
            walkingRunningTimeAsSecond: $1,
            walkingRunningDistanceAsMeter: $2,
            burnedKilocalories: $3
        )}
    }

    func fetchMeasuringExerciseRecord() -> Single<MeasuringExerciseRecord> {
        Single<MeasuringExerciseRecord>.zip(
            fetchMeasuringStepCount(),
            fetchMeasuringWalkingRunningTimeAsSecond(),
            fetchMeasuringWalkingRunningDistanceAsMeter(),
            fetchMeasuringSpeedAsMeterPerSecond(),
            fetchMeasuringBurnedKilocalories()
        ) { .init(
            stepCount: $0,
            wlkingRunningTimeAsSecond: $1,
            walkingRunningDistanceAsMeter: $2,
            speedAsMeterPerSecond: $3,
            burnedKilocalories: $4
        )}
    }

    // MARK: StepCount
    func fetchDailyStepCount() -> Single<Int> {
        healthKitDataSource.fetchStepCount(
            start: Calendar.current.startOfDay(for: Date()),
            end: Date()
        )
    }

    func fetchMeasuringStepCount() -> Single<Int> {
        if isMeasuring {
            return healthKitDataSource.fetchStepCount(
                start: measuringStartAt!,
                end: Date()
            )
        } else {
            return Single.error(WalkhubError.notMeasuring)
        }
    }

    // MARK: WalkingRunningTime
    func fetchDailyWalkingRunningTimeAsSecond() -> Single<Double> {
        healthKitDataSource.fetchWalkData(
            start: Calendar.current.startOfDay(for: Date()),
            end: Date()
        ).map { self.getSumOfTimeIntervalAsSecond(data: $0) }
    }

    func fetchMeasuringWalkingRunningTimeAsSecond() -> Single<Double> {
        if isMeasuring {
            return healthKitDataSource.fetchWalkData(
                start: measuringStartAt!,
                end: Date()
            ).map { self.getSumOfTimeIntervalAsSecond(data: $0) }
        } else { return Single.error(WalkhubError.notMeasuring) }
    }

    // MARK: WalkingRunningDistance
    func fetchDailyWalkingRunningDistanceAsMeter() -> Single<Double> {
        healthKitDataSource.fetchWalkDistance(
            start: Calendar.current.startOfDay(for: Date()),
            end: Date()
        )
    }

    func fetchMeasuringWalkingRunningDistanceAsMeter() -> Single<Double> {
        if isMeasuring {
            return healthKitDataSource.fetchWalkDistance(
                start: measuringStartAt!,
                end: Date()
            )
        } else { return Single.error(WalkhubError.notMeasuring) }
    }

    // MARK: Speed
    func fetchDailySpeedAsMeterPerSecond() -> Single<Double> {
        Single<Double>.zip(
            fetchDailyWalkingRunningDistanceAsMeter(),
            fetchDailyWalkingRunningTimeAsSecond()
        ) { $0/$1 }
    }

    func fetchMeasuringSpeedAsMeterPerSecond() -> Single<Double> {
        Single<Double>.zip(
            fetchMeasuringWalkingRunningDistanceAsMeter(),
            fetchMeasuringWalkingRunningTimeAsSecond()
        ) { $0/$1 }
    }

    // MARK: BurnedKilocalories
    // TODO: 데이터 가져오기 실패시 처리 특히 키/몸무게
    func fetchDailyBurnedKilocalories() -> Single<Double> {
        Single<Double>.zip(
            fetchDailySpeedAsMeterPerSecond().map { self.meterPerSecondToKillometerPerHour(meterPerSecond: $0) },
            fetchDailyWalkingRunningTimeAsSecond().map { self.secondToHour(second: $0) },
            healthKitDataSource.fetchUserWeight(),
            healthKitDataSource.fetchUserHeight(),
            fetchDailyStepCount()
        ) { speedAsKillometerPerHour, walkingRunningTimeAsHour, userWeight, userHeight, stepCount in
            let userSex = self.userDefaultsDataSource.userSex
            let met = self.calculateMET(speedAsKillometerPerHour: speedAsKillometerPerHour)
            let bmr = self.calculateBMR(
                userWeight: userWeight,
                userHeight: userHeight,
                userSex: userSex
            )
            return self.calculateBurnedKilocalories(
                userSex: userSex,
                met: met,
                bmr: bmr,
                timeAsHour: walkingRunningTimeAsHour,
                stepCount: stepCount
            )
        }
    }

    func fetchMeasuringBurnedKilocalories() -> Single<Double> {
        Single<Double>.zip(
            fetchMeasuringSpeedAsMeterPerSecond().map { self.meterPerSecondToKillometerPerHour(meterPerSecond: $0) },
            fetchMeasuringWalkingRunningTimeAsSecond().map { self.secondToHour(second: $0) },
            healthKitDataSource.fetchUserWeight(),
            healthKitDataSource.fetchUserHeight(),
            fetchMeasuringStepCount()
        ) { speedAsKillometerPerHour, walkingRunningTimeAsHour, userWeight, userHeight, stepCount in
            let userSex = self.userDefaultsDataSource.userSex
            let met = self.calculateMET(speedAsKillometerPerHour: speedAsKillometerPerHour)
            let bmr = self.calculateBMR(
                userWeight: userWeight,
                userHeight: userHeight,
                userSex: userSex
            )
            return self.calculateBurnedKilocalories(
                userSex: userSex,
                met: met,
                bmr: bmr,
                timeAsHour: walkingRunningTimeAsHour,
                stepCount: stepCount
            )
        }
    }

}

// MARK: - Private Methods
extension DefaultExercisesRepository {

    private func getSumOfTimeIntervalAsSecond(data: [HKSample]) -> Double {
        var secondSum = 0.0
        data.forEach {
            secondSum += ($0.endDate.timeIntervalSinceReferenceDate - $0.startDate.timeIntervalSinceReferenceDate)
        }
        return secondSum
    }

    private func calculateBurnedKilocalories(
        userSex: Sex,
        met: Double,
        bmr: Double,
        timeAsHour: Double,
        stepCount: Int
    ) -> Double {
        if userSex == .noAnswer {
            return Double(stepCount) / 30
        } else {
            return met * bmr / 24 * timeAsHour
        }
    }

    private func meterPerSecondToKillometerPerHour(meterPerSecond: Double) -> Double {
        return meterPerSecond*3.6
    }

    private func secondToHour(second: Double) -> Double {
        return second/3600
    }

    private func calculateBMR(userWeight: Double, userHeight: Double, userSex: Sex) -> Double {
        var bmr = (userWeight * 10) + (userHeight * 6.25) - 67.5
        bmr += userSex == .female ? -161 : 5
        return bmr
    }

    private func calculateMET(speedAsKillometerPerHour: Double) -> Double {
        return speedAsKillometerPerHour * 2.784 - 1.35
    }

}
