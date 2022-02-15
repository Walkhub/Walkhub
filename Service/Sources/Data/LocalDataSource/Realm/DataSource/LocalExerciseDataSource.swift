import Foundation

import RxSwift

final class LocalExerciseDataSource {

    static let shared = LocalExerciseDataSource()

    private init() { }

    func fetchMeasuredExercises() -> Single<[MeasuredExercise]> {
        return RealmTask.shared.fetchObjects(for: MeasuredExerciseRealmEntity.self)
            .map { $0.map { $0.toDomain() } }
    }

    func storeMeasuredExercises(_ measuredExerciseList: [MeasuredExercise]) {
        let measuredExerciseEntityList = measuredExerciseList.map { measuredExercise in
            return MeasuredExerciseRealmEntity().then {
                $0.setup(measuredExercise: measuredExercise)
            }
        }
        RealmTask.shared.set(measuredExerciseEntityList)
    }

    func fetchWalkCountRecordList() -> Single<[Int]> {
        return RealmTask.shared.fetchObjects(
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
        RealmTask.shared.set(walkCountEntityList)
    }

}
