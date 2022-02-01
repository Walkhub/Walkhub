import Foundation

import Moya
import RxSwift

final class RemoteNoticesDataSource: RestApiRemoteDataSource<NoticesAPI> {

    static let shared = RemoteNoticesDataSource()

    private override init() { }

    func fetchNotice() -> Single<Notice> {
        return request(.fetchNotice)
            .map(NoticeDTO.self)
            .map { $0.toDomain() }
    }
}
