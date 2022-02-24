import Foundation

final class UserDefaultsDataSource {

    static let shared = UserDefaultsDataSource()

    private let userDefaults = UserDefaults.standard

    private init() { }

    var userSex: Sex {
        get {
            Sex(rawValue: userDefaults.string(forKey: "userSex") ?? "") ?? .noAnswer
        }
        set(newValue) {
            userDefaults.set(newValue.rawValue, forKey: "userSex")
        }
    }

}
