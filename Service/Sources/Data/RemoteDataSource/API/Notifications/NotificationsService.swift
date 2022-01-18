//
//  NotificationsService.swift
//  Service
//
//  Created by kimsian on 2022/01/18.
//

import Foundation

import Moya
import RxSwift

final class NotificationsService: BaseService<NotificationsAPI> {
    func viewNotificationsList() -> Single<Response> {
        return request(.viewNotificationsList)
    }
    func editReadWhether(notificationID: Int) -> Single<Response> {
        return request(.editReadWhether(notificationID: notificationID))
    }
}
