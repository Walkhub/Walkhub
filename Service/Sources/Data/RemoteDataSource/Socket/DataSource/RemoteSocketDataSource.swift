import Foundation

import RxSwift
import SocketIO

final class RemoteCheeringDataSource: SocketRemoteDataSource<CheeringSocket> {

    static let shared = RemoteCheeringDataSource()

    private override init() { }

    func cheering(userID: Int) {
        emit(.cheering(userID: userID))
    }

    func observingCheering() -> Observable<String> {
        on(.observingCheer)
            .map {
                guard let data = $0 as? [[String: String]],
                      let message = data.last?["message"] else { return "" }
                return message
            }
    }

}
