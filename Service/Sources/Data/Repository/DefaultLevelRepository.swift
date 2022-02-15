import Foundation

import RxSwift

class DefaultLevelRepository: LevelRepository {
    func getCaloriesLevelList() -> Single<[CaloriesLevel]> {
        return RemoteLevelsDataSource.shared.fetchCaloriesLevelList()
    }

    func setMaxCaloriesLavel(levelId: Int) -> Single<Void> {
        return RemoteLevelsDataSource.shared.setMaxCaloriesLevel(levelId: levelId)
            .map { _ in () }
    }
}
