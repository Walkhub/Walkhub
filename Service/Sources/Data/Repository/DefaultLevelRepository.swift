import Foundation

import RxSwift

class DefaultLevelRepository: LevelRepository {

    private let remoteLevelDataSource = RemoteLevelsDataSource.shared
    private let localLevelDataSource = LocalCaloriesLevelDataSource.shared

    func fetchCaloriesLevelList() -> Observable<[CaloriesLevel]> {
        return OfflineCacheUtil<[CaloriesLevel]>()
            .localData { self.localLevelDataSource.fetchLevelList() }
            .remoteData { self.remoteLevelDataSource.fetchCaloriesLevelList() }
            .doOnNeedRefresh { self.localLevelDataSource.storeLevelList(caloriesLevel: $0) }
            .createObservable()
    }

    func setMaxCaloriesLevel(levelId: Int) -> Single<Void> {
        return remoteLevelDataSource.setMaxCaloriesLevel(levelId: levelId)
    }
}
