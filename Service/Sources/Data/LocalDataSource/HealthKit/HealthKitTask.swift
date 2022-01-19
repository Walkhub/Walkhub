import Foundation

import HealthKit
import RxSwift

class HealthKitTask {
    static let shared = HealthKitTask()
    let healthStore = HKHealthStore()
    func fetchData(start: Date, end: Date, dataType: HKQuantityTypeIdentifier, unit: HKUnit) -> Single<Double> {
        return Single<Double>.create { single in
            guard let sampleData = HKSampleType.quantityType(forIdentifier: dataType) else { fatalError() }
            let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
            let query = HKStatisticsQuery(quantityType: sampleData, quantitySamplePredicate: predicate,
                                          options: [.cumulativeSum]) { _, result, error in
                guard let quantity = result?.sumQuantity() else {
                    print(error?.localizedDescription ?? "")
                    single(.success(0.0))
                    return
                }
                single(.success(quantity.doubleValue(for: unit)))
            }
            self.healthStore.execute(query)
            return Disposables.create()
        }
    }
}
