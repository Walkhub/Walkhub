import Foundation

import RxSwift

public class FetchNoticeUseCase {
    private let noticeRepository: NoticeRepository

    init(noticeRepository: NoticeRepository) {
        self.noticeRepository = noticeRepository
    }

    public func excute() -> Observable<[Notice]> {
        return noticeRepository.fetchNoticeList()
    }
}
