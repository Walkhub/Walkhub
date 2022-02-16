import Foundation

import Moya
import RxSwift

final class RemoteLevelsDataSource: RestApiRemoteDataSource<LevelAPI> {

    static let shared = RemoteLevelsDataSource()

    func fetchCaloriesLevelList() -> Single<[CaloriesLevel]> {
        return request(.fetchCaloriesLevelList)
            .map(CaloriesLevelListDTO.self)
            .map { $0.toDomain() }
    }

    func setMaxCaloriesLevel(levelId: Int) -> Single<Void> {
        return request(.setMaxCaloriesLevel(levelId: levelId))
            .map { _ in () }
    }
}
