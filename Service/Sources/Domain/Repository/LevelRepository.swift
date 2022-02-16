import Foundation

import RxSwift

protocol LevelRepository {
    func fetchCaloriesLevelList() -> Observable<[CaloriesLevel]>
    func setMaxCaloriesLevel(levelId: Int) -> Single<Void>
}
