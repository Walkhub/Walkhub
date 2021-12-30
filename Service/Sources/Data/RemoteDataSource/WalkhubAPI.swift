import Foundation
import Moya

enum WalkhubAPI {
}

extension WalkhubAPI: TargetType {

    var baseURL: URL {
        return URL(string: "https:// ")!
    }

    var path: String {
        switch self {
        default:
            return "/"
        }
    }

    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    var task: Task {
        switch self {
        default:
            return .requestPlain
        }
    }

    var validationType: ValidationType {
        return .successCodes
    }

    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }

}
