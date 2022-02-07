import Foundation

import RxSwift

class LocalNoticeDataSource {

    static let shared = LocalNoticeDataSource()

    private init() { }

    func fetchNoticeList() -> Single<[Notice]> {
        return RealmTask.shared.fetchObjects(for: NoticeRealmEntity.self)
            .map { $0.map { $0.toDomain() } }
    }

    func storeNoticeList(noticeList: [Notice]) {
        let noticeRealmEntityList: [NoticeRealmEntity] = noticeList.map {
            let noticeRealmEntity = NoticeRealmEntity()
            noticeRealmEntity.setup(notice: $0)
            return noticeRealmEntity
        }
        RealmTask.shared.set(noticeRealmEntityList)
    }

}
