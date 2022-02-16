import Foundation

import RxSwift

final class LocalCaloriesLevelDataSource {

    static let shared = LocalCaloriesLevelDataSource()

    private let realm = RealmTask.shared

    private init() { }

    func fetchLevelList() -> Single<[CaloriesLevel]> {
        return realm.fetchObjects(
            for: CaloriesLevelRealmEntity.self
        ).map { $0.map { $0.toDomain() } }
    }

    func storeLevelList(caloriesLevel: [CaloriesLevel]) {
        let caloriesLevelList = caloriesLevel.map { level in
            return CaloriesLevelRealmEntity().then {
                $0.setup(caloriesLevel: level)
            }
        }
        realm.set(caloriesLevelList)
    }
}
