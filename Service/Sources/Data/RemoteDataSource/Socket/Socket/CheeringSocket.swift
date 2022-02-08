import Foundation

import SocketIO

enum CheeringSocket {
    case cheering(userID: Int)
}

extension CheeringSocket: WalkhubSocket {

    static var domain: SocketDomain {
        return .default
    }

    static var config: SocketIOClientConfiguration {
        return [.log(false), .compress, .forceWebsockets(true), .reconnects(true) ]
    }

    var event: String {
        switch self {
        case .cheering:
            return "cheering"
        }
    }

    var item: [String: Any]? {
        switch self {
        case .cheering(let userID):
            return ["user_id": userID]
        }
    }

}
