import Foundation

import Security

// MARK: - KeychainAccountType
enum KeychainAccountType: String {
    case accessToken = "ACCESS-TOKEN"
    case refreshToken = "REFRESH-TOKEN"
    case expiredAt = "EXPIRED-AT"
}

// MARK: - KeychainError
enum KeychainError: Error {
    case noData
}

// MARK: - KeychainTask
class KeychainTask {

    public static let shared = KeychainTask()

    private let service = Bundle.main.bundleIdentifier!

    private init() { }

    // MARK: Register
    public func register(accountType: KeychainAccountType, value: String) {
        let keychainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: accountType.rawValue,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
        ]
        SecItemDelete(keychainQuery)
        SecItemAdd(keychainQuery, nil)
    }

    // MARK: Fetch
    public func fetch(accountType: KeychainAccountType) throws -> String {
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
            guard let retrievedData = dataTypeRef as? Data else { throw KeychainError.noData }
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value!
        } else { throw KeychainError.noData }
    }

    // MARK: Delete
    public func delete(accountType: KeychainAccountType) {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: accountType.rawValue
        ]
        SecItemDelete(keyChainQuery)
    }

}
