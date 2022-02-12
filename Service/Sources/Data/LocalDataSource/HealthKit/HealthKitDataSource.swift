import Foundation

import HealthKit
import RxSwift

final class HealthKitDataSource {

    static let shared = HealthKitDataSource()

    private let healthKitTask = HealthKitTask.shared
    private let disposeBag = DisposeBag()

    private init() { }

    func observeStepCountDataSignal() -> Observable<Void> {
        return healthKitTask.observingDataChange(dataType: .stepCount)
    }

    func fetchStepCount(
        start: Date,
        end: Date
    ) ->  Single<Int> {
        return healthKitTask.fetchDataValue(
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
        return healthKitTask.fetchDataValue(
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
        return healthKitTask.fetchData(
            start: start,
            end: end,
            dataType: .stepCount
        )
    }

    func fetchUserHeight() -> Single<Double> {
        return healthKitTask.fetchData(
            dataCountLimit: 1,
            dataType: .height
        ).map { $0.first?.autoContentAccessingProxy as? Double ?? 0 }
    }

    func fetchUserWeight() -> Single<Double> {
        return healthKitTask.fetchData(
            dataCountLimit: 1,
            dataType: .bodyMass
        ).map { $0.first?.autoContentAccessingProxy as? Double ?? 0 }
    }

    func storeUserHeight(_ height: Double) {
        healthKitTask.storeData(
            dataValue: height,
            unit: .meterUnit(with: .centi),
            date: Date(),
            dataType: .height
        )
    }

    func storeUserWeight(_ weight: Double) {
        healthKitTask.storeData(
            dataValue: weight,
            unit: .gramUnit(with: .kilo),
            date: Date(),
            dataType: .height
        )
    }

}
