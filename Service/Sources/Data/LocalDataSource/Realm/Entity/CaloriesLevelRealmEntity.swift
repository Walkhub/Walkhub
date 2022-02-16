import Foundation

import RealmSwift

class CaloriesLevelRealmEntity: Object {
    @Persisted(primaryKey: true) var levelId: Int = 0
    @Persisted var foodName: String = ""
    @Persisted var foodImageUrlString: String = ""
    @Persisted var calorie: Int = 0
    @Persisted var size: String = ""
    @Persisted var level: Int = 0
    @Persisted var message: String = ""
}

extension CaloriesLevelRealmEntity {
    func setup(caloriesLevel: CaloriesLevel) {
        self.levelId = caloriesLevel.level
        self.foodName = caloriesLevel.foodName
        self.foodImageUrlString = caloriesLevel.foodImageUrlString.absoluteString
        self.calorie = caloriesLevel.calorie
        self.size = caloriesLevel.size
        self.level = caloriesLevel.level
        self.message = caloriesLevel.message
    }
}

extension CaloriesLevelRealmEntity {
    func toDomain() -> CaloriesLevel {
        return .init(
            levelID: levelId,
            foodImageUrlString: URL(string: foodImageUrlString)!,
            foodName: foodName,
            calorie: calorie,
            size: size,
            level: level,
            message: message
        )
    }
}
