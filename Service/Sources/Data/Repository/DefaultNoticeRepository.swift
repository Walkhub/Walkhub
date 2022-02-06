import Foundation

import RxSwift

class DefaultNoticeRepository: NoticeRepository {
    func fetchNoticeList() -> Observable<[Notice]> {
        return OfflineCacheUtil<[Notice]>()
            .remoteData { RemoteNoticeDataSource.shared.fetchNoticeList() }
            .localData { LocalNoticeDataSource.shared.fetchNoticeList() }
            .doOnNeedRefresh { LocalNoticeDataSource.shared.storeNoticeList(noticeList: $0) }
            .createObservable()
    }
}
