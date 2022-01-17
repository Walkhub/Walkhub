import Foundation

public enum WalkhubError: Error {

    // Base
    case noInternet
    case unauthorization
    case forbidden

    // Auth
    case invalidAuthCode
    case duplicateId
    case faildSignin

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
        case .invalidAuthCode:
            return "Auth Code Is Invalid"
        case .duplicateId:
            return "The Id Is Duplicate"
        case .faildSignin:
            return "ID Or Password Is Incorrect"
        }
    }
}
