import Foundation

import Moya
import RxSwift

// MARK: - JWTTokenAuthorizable
public protocol JWTTokenAuthorizable {
    var jwtTokenType: JWTTokenType? { get }
}

// MARK: - JWTTokenType
public enum JWTTokenType {

    case none

    case accessToken
    case refreshToken

    public var headerString: String? {
        switch self {
        case .accessToken:
            return "Authorization"
        case .refreshToken:
            return "X-Refresh-Token"
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

    public func prepare(
        _ request: URLRequest,
        target: TargetType
    ) throws -> URLRequest {

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
