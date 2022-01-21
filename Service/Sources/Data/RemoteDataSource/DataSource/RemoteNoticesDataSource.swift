import Foundation

import Moya
import RxSwift

final class RemoteNoticesDataSource: RemoteBaseDataSource<NoticesAPI> {

    static let shared = RemoteNoticesDataSource()

    private override init() { }

    func fetchNotice() -> Single<Response> {
        return request(.fetchNotice)
    }
}
