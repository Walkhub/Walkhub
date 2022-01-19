import Foundation

import HealthKit

class HealthKitDataSoruce {
    let healthStore = HKHealthStore()
    func fetchData(start: Date, end: Date, dataType: HKQuantityTypeIdentifier, unit: HKUnit,
                   completion: @escaping (Double) -> Void) {
        guard let sampleData = HKSampleType.quantityType(forIdentifier: dataType) else { fatalError() }
        let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: sampleData, quantitySamplePredicate: predicate,
                                      options: [.cumulativeSum]) { _, result, error in
            guard let quantity = result?.sumQuantity() else {
                print(error?.localizedDescription ?? "")
                completion(0.0)
                return
            }
            DispatchQueue.main.async {
                completion(quantity.doubleValue(for: unit))
            }
        }
        healthStore.execute(query)
    }
}
