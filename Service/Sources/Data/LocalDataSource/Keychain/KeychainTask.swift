import Foundation

import Security

// MARK: - KeychainTask
class KeychainTask {

    public static let shared = KeychainTask()

    private let service = Bundle.main.bundleIdentifier!

    private init() { }

    // MARK: Register
    public func register(accontType: AccountType, value: String) {
        let keychainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: accontType.rawValue,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
        ]
        SecItemDelete(keychainQuery)
        SecItemAdd(keychainQuery, nil)
    }

    // MARK: Fetch
    public func fetch(accountType: AccountType) -> String? {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: accountType.rawValue,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(keyChainQuery, &dataTypeRef)
        if status == errSecSuccess {
            guard let retrievedData = dataTypeRef as? Data else { return nil }
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value
        } else { return nil }
    }

    // MARK: Delete
    public func delete(accountType: AccountType) {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: accountType.rawValue
        ]
        SecItemDelete(keyChainQuery)
    }

    // MARK: Delete All
    public func deleteAll() {
        AccountType.allCases.forEach { accountType in
            self.delete(accountType: accountType)
        }
    }

}

// MARK: - AccountType
enum AccountType: String, CaseIterable {
    case accessToken = "ACCESS-TOKEN"
    case refreshToken = "REFRESH-TOKEN"
}
