import Foundation

import SocketIO

protocol WalkhubSocket {
    static var domain: SocketDomain { get }
    static var config: SocketIOClientConfiguration { get }
    var event: String { get }
    var item: [String: Any]? { get }
}

extension WalkhubSocket {

    static private var baseURL: URL { URL(string: "https://api.walkhub.co.kr")! }

    static private var manager: SocketManager {
        SocketManager(socketURL: baseURL, config: config)
    }

    static var socketClient: SocketIOClient {
        manager.socket(forNamespace: domain.nameSpace)
    }

}

// MARK: - SocketDomain enum
enum SocketDomain: String {
    case `default`
}

extension SocketDomain {
    var nameSpace: String {
        switch self {
        case .default: return "/"
        default: return "/\(self.rawValue)"
        }
    }
}
