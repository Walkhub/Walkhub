import Foundation

import HealthKit
import RxSwift

final class HealthKitDataSource {

    static let shared = HealthKitDataSource()

    private let disposeBag = DisposeBag()

    private init() { }

    func observeStepCountDataSignal() -> Observable<Void> {
        return HealthKitTask.shared.observingDataChange(dataType: .stepCount)
    }

    func fetchStepCount(
        start: Date,
        end: Date
    ) ->  Single<Int> {
        return HealthKitTask.shared.fetchDataValue(
            start: start,
            end: end,
            dataType: .stepCount,
            unit: .count()
        ).map { Int($0) }
    }

    func fetchWalkDistance(
        start: Date,
        end: Date
    ) -> Single<Double> {
        return HealthKitTask.shared.fetchDataValue(
            start: start,
            end: end,
            dataType: .distanceWalkingRunning,
            unit: .meter()
        )
    }

    func fetchWalkData(
        start: Date,
        end: Date
    ) -> Single<[HKSample]> {
        return HealthKitTask.shared.fetchData(
            start: start,
            end: end,
            dataType: .stepCount
        )
    }

}
