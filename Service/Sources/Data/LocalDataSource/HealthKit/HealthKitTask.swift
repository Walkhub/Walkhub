import Foundation

import HealthKit
import RxSwift

final public class HealthKitTask {

    public static let shared = HealthKitTask()

    let healthStore = HKHealthStore()
    let healthKitTypes: Set = [
        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        HKObjectType.quantityType(forIdentifier: .stepCount)!
    ]

    private init() { }

    public func fetchData(start: Date, end: Date, dataType: HKQuantityTypeIdentifier, unit: HKUnit) -> Single<Double> {
        return Single<Double>.create { single in
            guard let sampleData = HKSampleType.quantityType(forIdentifier: dataType) else { fatalError() }
            let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
            let query = HKStatisticsQuery(
                quantityType: sampleData,
                quantitySamplePredicate: predicate,
                options: [.cumulativeSum]
            ) { _, result, error in
                guard let quantity = result?.sumQuantity() else {
                    single(.failure(error!))
                    return
                }
                single(.success(quantity.doubleValue(for: unit)))
            }
            self.healthStore.execute(query)
            return Disposables.create()
        }
    }

    public func setHealthKit() {
        healthStore.requestAuthorization(toShare: nil, read: healthKitTypes) { _, _ in }
    }
}
