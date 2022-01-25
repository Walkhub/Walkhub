import Foundation

import RxSwift

public class HealthKitDataSource {

    public func stepCount(
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

    public func walkDistance(
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
