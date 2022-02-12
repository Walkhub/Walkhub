import Foundation

import HealthKit
import RxSwift

// MARK: - HealthKitError
enum HealthKitError: Error {
    case unauthorizationHealthKit
}

// MARK: - HealthKitTask
final class HealthKitTask {

    static let shared = HealthKitTask()

    private let disposeBag = DisposeBag()
    private let healthStore = HKHealthStore()
    private let healthKitTypesToWrite: Set<HKSampleType> = [
        .quantityType(forIdentifier: .height)!,
        .quantityType(forIdentifier: .bodyMass)!
    ]
    private let healthKitTypesToRead: Set<HKObjectType> = [
        .quantityType(forIdentifier: .stepCount)!,
        .quantityType(forIdentifier: .distanceWalkingRunning)!,
        .quantityType(forIdentifier: .height)!,
        .quantityType(forIdentifier: .bodyMass)!
    ]

    private init() { }

    func fetchData(start: Date, end: Date, dataType: HKQuantityTypeIdentifier) -> Single<[HKSample]> {
        return Single<[HKSample]>.create { single in
            let authorization = self.requestAuthorization()
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
                }, onFailure: {
                    single(.failure($0))
                })
            return Disposables.create([authorization])
        }
    }

    func fetchData(dataCountLimit: Int, dataType: HKQuantityTypeIdentifier) -> Single<[HKSample]> {
        return Single<[HKSample]>.create { single in
            let authorization = self.requestAuthorization()
                .subscribe(onSuccess: { _ in
                    let sampleType = HKSampleType.quantityType(forIdentifier: dataType)!
                    let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
                    let query = HKSampleQuery(
                        sampleType: sampleType,
                        predicate: nil,
                        limit: dataCountLimit,
                        sortDescriptors: [sortDescriptor]
                    ) { _, result, error in
                        guard let result = result else {
                            single(.failure(error!))
                            return
                        }
                        single(.success(result))
                    }

                    self.healthStore.execute(query)
                }, onFailure: {
                    single(.failure($0))
                })
            return Disposables.create([authorization])
        }
    }

    func fetchDataValue(start: Date, end: Date, dataType: HKQuantityTypeIdentifier, unit: HKUnit) -> Single<Double> {
        return Single<Double>.create { single in
            let authorization = self.requestAuthorization()
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
                }, onFailure: {
                    single(.failure($0))
                })
            return Disposables.create([authorization])
        }
    }

    func storeData(
        dataValue: Double,
        unit: HKUnit,
        date: Date,
        dataType: HKQuantityTypeIdentifier
    ) {
        requestAuthorization()
            .subscribe(onSuccess: { _ in
                HKHealthStore().save(HKQuantitySample(
                    type: .quantityType(forIdentifier: dataType)!,
                    quantity: .init(unit: unit, doubleValue: dataValue),
                    start: date,
                    end: date
                )) { _, _ in return }
            }).disposed(by: disposeBag)
    }

    func observingDataChange(dataType: HKQuantityTypeIdentifier) -> Observable<Void> {
        return Observable<Void>.create { observer in
            let authorization = self.requestAuthorization()
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
                }, onFailure: {
                    observer.onError($0)
                })
            return Disposables.create([authorization])
        }
    }

    private func requestAuthorization() -> Single<Void> {
        return Single<Void>.create { single in
            self.healthStore.requestAuthorization(
                toShare: self.healthKitTypesToWrite,
                read: self.healthKitTypesToRead
            ) { isAllowed, _ in
                if isAllowed {
                    single(.success(()))
                } else {
                    single(.failure(HealthKitError.unauthorizationHealthKit))
                }
            }
            return Disposables.create()
        }
    }

}
