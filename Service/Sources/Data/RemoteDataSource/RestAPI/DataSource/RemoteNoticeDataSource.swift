import Foundation

import Moya
import RxSwift

final class RemoteNoticeDataSource: RestApiRemoteDataSource<NoticeAPI> {

    static let shared = RemoteNoticeDataSource()

    private override init() { }

    func fetchNoticeList() -> Single<[Notice]> {
        return request(.fetchNotice)
            .map(NoticeListDTO.self)
            .map { $0.toDomain() }
    }
}
