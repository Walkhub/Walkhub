import Foundation

import RealmSwift

class LevelRealmEntity: Object {
    @Persisted var name: String = ""
    @Persisted var imageUrlString: String = ""
}

extension LevelRealmEntity {
    func setup(level: Level) {
        self.name = level.name
        self.imageUrlString = level.imageUrlString.absoluteString
    }
}

extension LevelRealmEntity {
    func toDomain() -> Level {
        return .init(
            name: name,
            imageUrlString: URL(string: imageUrlString)!
        )
    }
}
