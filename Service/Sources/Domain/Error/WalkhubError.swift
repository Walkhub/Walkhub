import Foundation

public enum WalkhubError: Error {
    case noInternet
}

extension WalkhubError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No Internet Connection"
        }
    }
}
