import Foundation

import Moya
import RxSwift

final class NoticesService: BaseService<NoticesAPI> {
    
    static let shared = NoticesService()
    
    private override init() {}
    
    func fetchNotice() -> Single<Response> {
        return request(.fetchNotice)
    }
}
