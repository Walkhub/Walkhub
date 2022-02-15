import Foundation

import RxSwift

class DefaultNoticeRepository: NoticeRepository {

    private let remoteNoticeDataSource = RemoteNoticeDataSource.shared
    private let localNoticeDataSource = LocalNoticeDataSource.shared

    func fetchNoticeList() -> Observable<[Notice]> {
        return OfflineCacheUtil<[Notice]>()
            .localData { self.localNoticeDataSource.fetchNoticeList() }
            .remoteData { self.remoteNoticeDataSource.fetchNoticeList() }
            .doOnNeedRefresh { self.localNoticeDataSource.storeNoticeList(noticeList: $0) }
            .createObservable()
    }

}
