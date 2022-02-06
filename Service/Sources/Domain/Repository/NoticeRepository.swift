import Foundation

import RxSwift

protocol NoticeRepository {
    func fetchNoticeList() -> Observable<[Notice]>
}
