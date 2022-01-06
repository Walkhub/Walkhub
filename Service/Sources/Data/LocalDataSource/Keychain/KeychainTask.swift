import Foundation

import Security

// MARK: - KeychainTask
class KeychainTask {

    public static let shared = KeychainTask()

    private let service = Bundle.main.bundleIdentifier!

    private init() { }

    // MARK: Register
    public func register(accont: String, value: String) {
        let keychainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: accont,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
        ]
        SecItemDelete(keychainQuery)
        SecItemAdd(keychainQuery, nil)
    }

    // MARK: Fetch
    public func fetch(account: String) -> String? {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
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
    public func delete(account: String) {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ]
        SecItemDelete(keyChainQuery)
    }

}
