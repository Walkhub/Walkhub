import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class NotificationListViewModel: ViewModelType, Stepper {
    private let fetchNotificationListUseCase: FetchNotificationListUseCase

    init(fetchNotificationListUseCase: FetchNotificationListUseCase) {
        self.fetchNotificationListUseCase = fetchNotificationListUseCase
    }

    struct Input {
        let getData: Driver<Void>
    }

    struct Output {
        let notificationList: BehaviorRelay<[NotificationData]>
    }

    var steps = PublishRelay<Step>()
    private var disposeBag = DisposeBag()

    func transform(_ input: Input) -> Output {
        let notificationList = BehaviorRelay<[NotificationData]>(value: [])

        input.getData.asObservable()
            .flatMap {
                self.fetchNotificationListUseCase.excute()
            }.subscribe(onNext: {
                notificationList.accept($0)
            }).disposed(by: disposeBag)

        return Output(notificationList: notificationList)
    }
}
