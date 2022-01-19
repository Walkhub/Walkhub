import Foundation

import HealthKit
import RxSwift

@available(iOS 14.5, *)
final public class HealthKitTask {

    public static let shared = HealthKitTask()

    let healthStore = HKHealthStore()
    let healthKitTypes: Set = [
        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        HKObjectType.quantityType(forIdentifier: .stepCount)!,
        HKObjectType.quantityType(forIdentifier: .appleMoveTime)!
    ]

    private init() { }

    public func fetchData(start: Date, end: Date, dataType: HKQuantityTypeIdentifier, unit: HKUnit) -> Single<Double> {
        return Single<Double>.create { single in
            self.requestPermission()
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

    private func requestPermission() {
        healthStore.requestAuthorization(toShare: nil, read: healthKitTypes) { success, error in
            print(success)
            if success { return }
            else {
                print(error?.localizedDescription as Any)
            }
        }
    }

}
