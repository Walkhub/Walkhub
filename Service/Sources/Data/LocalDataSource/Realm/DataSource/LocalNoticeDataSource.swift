import Foundation

import RxSwift

final class LocalNoticeDataSource {

    static let shared = LocalNoticeDataSource()

    private init() { }

    func fetchNoticeList() -> Single<[Notice]> {
        return RealmTask.shared.fetchObjects(for: NoticeRealmEntity.self)
            .map { $0.map { $0.toDomain() } }
    }

    func storeNoticeList(noticeList: [Notice]) {
        let noticeRealmEntityList = noticeList.map { notice in
            return NoticeRealmEntity().then {
                $0.setup(notice: notice)
            }
        }
        RealmTask.shared.set(noticeRealmEntityList)
    }

}
