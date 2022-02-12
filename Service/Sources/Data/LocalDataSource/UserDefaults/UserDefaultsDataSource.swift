import Foundation

class UserDefaultsDataSource {

    let shared = UserDefaultsDataSource()

    private let userDefaults = UserDefaults.standard

    var userSex: Sex {
        get {
            Sex(rawValue: userDefaults.string(forKey: "userSex") ?? "") ?? .noAnswer
        }
        set(newValue) {
            userDefaults.set(newValue, forKey: "userSex")
        }
    }

}
