import Foundation

public enum WalkhubError: Error {
    case noInternet
    case unauthorization
    case forbidden
}

extension WalkhubError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No Internet Connection"
        case .unauthorization:
            return "Authentication Error"
        case .forbidden:
            return "No Permission"
        }
    }
}
