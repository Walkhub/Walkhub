import Foundation

import RxSwift

class HealthKitDataSource {
    
    public static let shared = HealthKitDataSource()
    
    private init()

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
