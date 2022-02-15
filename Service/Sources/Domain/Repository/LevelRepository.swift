import Foundation

import RxSwift

protocol LevelRepository {
    func getCaloriesLevelList() -> Single<[CaloriesLevel]>
    func setMaxCaloriesLavel(levelId: Int) -> Single<Void>
}
