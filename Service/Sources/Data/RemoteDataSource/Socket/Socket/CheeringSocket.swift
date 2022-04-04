import Foundation

import SocketIO

enum CheeringSocket {
    // for emit
    case cheering(userID: Int)

    // for on
    case observingCheer
}

extension CheeringSocket: WalkhubSocket {

    static var domain: SocketDomain {
        return .default
    }

    static var config: SocketIOClientConfiguration {
        let token = try? KeychainTask.shared.fetch(accountType: .accessToken)
        return [
            .forceWebsockets(true),
            .extraHeaders(["Authorization": token ?? ""])
        ]
    }

    var event: String {
        switch self {
        case .cheering:
            return "cheering"
        case .observingCheer:
            return "new_cheering"
        }
    }

    var item: [String: Any]? {
        switch self {
        case .cheering(let userID):
            return ["user_id": userID]
        default:
            return nil
        }
    }

}
