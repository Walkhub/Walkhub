import Foundation

final class KeychainDataSource {

    static let shared = KeychainDataSource()

    private let keychainTask = KeychainTask.shared

    private init() { }

    func registerAccessToken(_ accessToken: String) {
        keychainTask.register(accountType: .accessToken, value: accessToken)
    }

    func fetchAccessToken() throws -> String {
        try keychainTask.fetch(accountType: .accessToken)
    }

    func registerRefreshToken(_ refreshToken: String) {
        keychainTask.register(accountType: .refreshToken, value: refreshToken)
    }

    func fetchRefreshToken() throws -> String {
        try keychainTask.fetch(accountType: .refreshToken)
    }

    func registerExpiredAt(_ expiredAt: String) {
        keychainTask.register(accountType: .expiredAt, value: expiredAt)
    }

    func fetchExpiredDate() throws -> Date {
        try keychainTask.fetch(accountType: .expiredAt).toDateWithTime()
    }

}
