import Foundation

import RxSwift

protocol NoticesRepository {
    func seeNotice() -> Single<NoticeListDTO>
    func writeNotice(title: String, content: String, scope: String) -> Single<Void>
    func deleteNotice(noticeID: Int) -> Single<Void>
}
