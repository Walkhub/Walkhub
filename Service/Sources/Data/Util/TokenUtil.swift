import Foundation

// MARK: - Token Type
enum TokenType {
    case accessToken
    case refreshToken
}

extension TokenType {
    var keychainAccount: String {
        switch self {
        case .accessToken:
            return "ACCESS-TOKEN"
        case .refreshToken:
            return "REFRESH-TOKEN"
        }
    }
}
