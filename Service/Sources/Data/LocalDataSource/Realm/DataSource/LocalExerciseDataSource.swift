import Foundation

import RxSwift

final class LocalExerciseDataSource {

    static let shared = LocalExerciseDataSource()

    private let realmTask = RealmTask.shared

    private init() { }

    func fetchMeasuredExercises() -> Single<[MeasuredExercise]> {
        return realmTask.fetchObjects(for: MeasuredExerciseRealmEntity.self)
            .map { $0.map { $0.toDomain() } }
    }

    func storeMeasuredExercises(_ measuredExerciseList: [MeasuredExercise]) {
        let measuredExerciseEntityList = measuredExerciseList.map { measuredExercise in
            return MeasuredExerciseRealmEntity().then {
                $0.setup(measuredExercise: measuredExercise)
            }
        }
        realmTask.set(measuredExerciseEntityList)
    }

    func fetchWalkCountRecordList() -> Single<[Int]> {
        return realmTask.fetchObjects(
            for: WalkCountRecordRealmEntity.self,
               sortProperty: "index"
        ).map { $0.map { $0.toDomain() }.reversed() }
    }

    func storeWalkCountRecordList(_ walkCountList: [Int]) {
        let walkCountEntityList = walkCountList
            .reversed()
            .enumerated()
            .map { item in
            return WalkCountRecordRealmEntity().then {
                $0.setup(index: item.0, walkCount: item.1)
            }
        }
        realmTask.set(walkCountEntityList)
    }

}
