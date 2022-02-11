import Foundation

import HealthKit
import RxSwift

final class HealthKitTask {

    static let shared = HealthKitTask()

    let healthStore = HKHealthStore()
    let healthKitTypes: Set = [
        HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        HKObjectType.quantityType(forIdentifier: .stepCount)!
    ]

    private init() { }

    func fetchData(start: Date, end: Date, dataType: HKQuantityTypeIdentifier) -> Single<[HKSample]> {
        return Single<[HKSample]>.create { single in
            let authorization = self.requestAuthorization()
                .filter { $0 }
                .subscribe(onSuccess: { _ in
                    let sampleType = HKSampleType.quantityType(forIdentifier: dataType)!
                    let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
                    let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
                    let query = HKSampleQuery(
                        sampleType: sampleType,
                        predicate: predicate,
                        limit: HKObjectQueryNoLimit,
                        sortDescriptors: [sortDescriptor]
                    ) { _, result, error in
                        guard let result = result else {
                            single(.failure(error!))
                            return
                        }
                        single(.success(result))
                    }

                    self.healthStore.execute(query)
                })
            return Disposables.create([authorization])
        }
    }

    func fetchDataValue(start: Date, end: Date, dataType: HKQuantityTypeIdentifier, unit: HKUnit) -> Single<Double> {
        return Single<Double>.create { single in
            let authorization = self.requestAuthorization()
                .filter { $0 }
                .subscribe(onSuccess: { _ in
                    let sampleType = HKSampleType.quantityType(forIdentifier: dataType)!
                    let predicate = HKQuery.predicateForSamples(withStart: start, end: end, options: .strictStartDate)
                    let query = HKStatisticsQuery(
                        quantityType: sampleType,
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
                })
            return Disposables.create([authorization])
        }
    }

    func observingDataChange(dataType: HKQuantityTypeIdentifier) -> Observable<Void> {
        return Observable<Void>.create { observer in
            let authorization = self.requestAuthorization()
                .filter { $0 }
                .subscribe(onSuccess: { _ in
                    let sampleType = HKSampleType.quantityType(forIdentifier: dataType)!

                    let query = HKObserverQuery(sampleType: sampleType, predicate: nil) { _, _, error in
                        if let error = error {
                            observer.onError(error)
                            return
                        }
                        observer.onNext(())
                    }

                    self.healthStore.execute(query)
                })
            return Disposables.create([authorization])
        }
    }

    private func requestAuthorization() -> Single<Bool> {
        return Single<Bool>.create { single in
            self.healthStore.requestAuthorization(toShare: nil, read: self.healthKitTypes) { isAllowed, _ in
                single(.success(isAllowed))
            }
            return Disposables.create()
        }
    }

}
