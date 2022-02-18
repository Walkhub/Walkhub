import Foundation

import Moya
import RxSwift

// MARK: - JWTTokenAuthorizable
protocol JWTTokenAuthorizable {
    var jwtTokenType: JWTTokenType? { get }
}

// MARK: - JWTTokenType
enum JWTTokenType {

    case none

    case accessToken
    case refreshToken

    public var headerString: String? {
        switch self {
        case .accessToken:
            return "Authorization"
        case .refreshToken:
            return "Refresh-Token"
        default:
            return nil
        }
    }
}

// MARK: - TokenError
enum TokenError: Error {
    case noToken
    case tokenExpired
}

// MARK: - JWTPlugin
final class JWTPlugin: PluginType {

    private let keychainDataSource = KeychainDataSource.shared

    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let authorizable = target as? JWTTokenAuthorizable,
              let tokenType = authorizable.jwtTokenType,
              tokenType != .none
        else { return request }

        var request = request

        let authValue = "Bearer \(getToken(type: tokenType)!)"
        request.addValue(authValue, forHTTPHeaderField: tokenType.headerString!)
        return request
    }

}

extension JWTPlugin {

    private func getToken(type: JWTTokenType) -> String? {
        switch type {
        case .none:
            return nil
        case .accessToken:
            return fetchAccessToken()
        case .refreshToken:
            return fetchRefreshToken()
        }
    }

    private func fetchAccessToken() -> String {
        do {
            return try keychainDataSource.fetchAccessToken()
        } catch {
            return ""
        }
    }

    private func fetchRefreshToken() -> String {
        do {
            return try keychainDataSource.fetchRefreshToken()
        } catch {
            return ""
        }
    }

}
