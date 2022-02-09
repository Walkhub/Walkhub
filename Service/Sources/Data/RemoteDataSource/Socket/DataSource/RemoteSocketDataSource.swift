import Foundation

import RxSwift
import SocketIO

final class RemoteSocketDataSource: SocketRemoteDataSource<CheeringSocket> {

    static let shared = RemoteSocketDataSource()

    private override init() { }

    func cheering(userID: Int) {
        emit(.cheering(userID: userID))
    }

}
