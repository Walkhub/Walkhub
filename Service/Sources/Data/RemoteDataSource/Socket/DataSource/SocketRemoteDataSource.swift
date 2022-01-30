import Foundation

import RxSwift
import SocketIO

class SocketRemoteDataSource<Socket: WalkhubSocket> {

    private let socketClient = Socket.socketClient

    func establishConnection() {
        socketClient.connect()
    }

    func closeConnection() {
        socketClient.disconnect()
    }

    func on(_ socket: Socket) -> Observable<[Any]> {
        return Observable<[Any]>.create { observer in
            self.socketClient.on(socket.event) { data, _ in
                observer.onNext(data)
            }
            return Disposables.create()
        }
    }

    func emit(_ socket: Socket) {
        socketClient.emit(socket.event, socket.item ?? [])
    }

}
