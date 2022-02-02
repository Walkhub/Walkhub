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

// MARK: - JWTPlugin
final class JWTPlugin: PluginType {

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

    public func didReceive(
        _ result: Result<Response, MoyaError>,
        target: TargetType
    ) {
        switch result {
        case .success(let response):
            if let newToken = try? response.map(TokenDTO.self) {
                self.setToken(token: newToken)
            }
        default : break
        }
    }

}

extension JWTPlugin {

    private func getToken(type: JWTTokenType) -> String? {
        switch type {
        case .none:
            return nil
        case .accessToken:
            return getAccessToken()
        case .refreshToken:
            return getRefreshToken()
        }
    }

    private func getAccessToken() -> String {
        do {
            return try KeychainTask.shared.fetch(accountType: .accessToken)
        } catch {
            return ""
        }
    }

    private func getRefreshToken() -> String {
        do {
            return try KeychainTask.shared.fetch(accountType: .refreshToken)
        } catch {
            return ""
        }
    }

    private func setToken(token: TokenDTO) {
        KeychainTask.shared.register(accountType: .accessToken, value: token.accessToken)
        KeychainTask.shared.register(accountType: .refreshToken, value: token.refreshToken)
        KeychainTask.shared.register(accountType: .expiredAt, value: token.expiredAt)
    }

}

// MARK: - TokenError
enum TokenError: Error {
    case noToken
    case tokenExpired
}
