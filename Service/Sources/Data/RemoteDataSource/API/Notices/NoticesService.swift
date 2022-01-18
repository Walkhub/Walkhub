import Foundation

import Moya
import RxSwift

final class NoticesService: BaseService<NoticesAPI> {
    
    static let shared = NoticesService()
    
    private override init() {}
    
    func fetchNotice() -> Single<Response> {
        return request(.fetchNotice)
    }
    
    func writeNotice(
        title: String,
        content: String,
        scope: String
    ) -> Single<Response> {
        return request(.writeNotice(
            title: title,
            content: content,
            scope: scope))
    }
    
    func deleteNotice(noticeID: Int) -> Single<Response> {
        return request(.deleteNotice(noticeID: noticeID))
    }
}
