import Foundation
import RxSwift
import Moya

class DefaultNoticesRepository: NoticesRepository {
    func seeNotice() -> Single<NoticeListDTO> {
        return NoticesService.shared.seeNotice()
            .map(NoticeListDTO.self)
            .map { return $0 }
            .catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError.errorCode {
                    case 401: return Single.error(WalkhubError.unauthorization)
                    default: return Single.error(error)
                    }
                } else { return Single.error(error) }
            }
    }
    
    func writeNotice(
        title: String,
        content: String,
        scope: String
    ) -> Single<Void> {
        return NoticesService.shared.writeNotice(
            title: title,
            content: content,
            scope: scope
        ).map { _ in
            return ()
        }.catch { error in
            if let moyaError = error as? MoyaError {
                switch moyaError.errorCode {
                case 401: return Single.error(WalkhubError.unauthorization)
                case 403: return Single.error(WalkhubError.forbidden)
                default: return Single.error(error)
                }
            } else { return Single.error(error) }
        }
    }
    
    func deleteNotice(noticeID: Int) -> Single<Void> {
        return NoticesService.shared.deleteNotice(noticeID: noticeID)
            .map { _ in
                return ()
            }.catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError.errorCode {
                    case 401: return Single.error(WalkhubError.unauthorization)
                    case 403: return Single.error(WalkhubError.forbidden)
                    case 404: return Single.error(WalkhubError.faildFound)
                    default: return Single.error(error)
                    }
                } else { return Single.error(error) }
            }
    }
    
    
}
