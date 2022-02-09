import Foundation

import RxSwift

final class HealthKitDataSource {

    static let shared = HealthKitDataSource()

    private init() { }

    func stepCount(
        start: Date,
        end: Date
    ) ->  Single<Double> {
        return HealthKitTask.shared.fetchData(
            start: start,
            end: end,
            dataType: .stepCount,
            unit: .count()
        )
    }

    func walkDistance(
        start: Date,
        end: Date
    ) -> Single<Double> {
        return HealthKitTask.shared.fetchData(
            start: start,
            end: end,
            dataType: .distanceWalkingRunning,
            unit: .meter()
        )
    }

}
