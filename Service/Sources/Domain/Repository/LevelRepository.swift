import Foundation

import RxSwift

protocol LevelRepository {
    func getCaloriesLevelList() -> Single<[CaloriesLevel]>
    func setMaxCaloriesLevel(levelId: Int) -> Single<Void>
}
