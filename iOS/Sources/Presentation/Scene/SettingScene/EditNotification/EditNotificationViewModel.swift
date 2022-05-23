import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class EditNotificationViewModel: ViewModelType, Stepper {

    private let fetchNotificationStatusUseCase: FetchNotificationStatusUseCase
    private let notificationOnUseCase: NotificationOnUseCase
    private let notificationOffUseCase: NotificationOffUseCase

    init(
        fetchNotificationStatusUseCase: FetchNotificationStatusUseCase,
        notificationOnUseCase: NotificationOnUseCase,
        notificationOffUseCase: NotificationOffUseCase
    ) {
        self.fetchNotificationStatusUseCase = fetchNotificationStatusUseCase
        self.notificationOnUseCase = notificationOnUseCase
        self.notificationOffUseCase = notificationOffUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let getData: Driver<Void>
        let challengeNotification: Driver<Bool>
        let challengeSuccess: Driver<Bool>
        let challegeExpiration: Driver<Bool>
        let notification: Driver<Bool>
        let cheeringNotification: Driver<Bool>
    }

    struct Output {
        let notificationStatus: PublishRelay<[NotificationStatus]>
    }

    func transform(_ input: Input) -> Output {
        let notificationStatus = PublishRelay<[NotificationStatus]>()

        input.getData.asObservable()
            .flatMap {
                self.fetchNotificationStatusUseCase.excute()
            }.subscribe(onNext: {
                notificationStatus.accept($0)
            }).disposed(by: disposeBag)

        input.challengeNotification.asObservable()
            .flatMap { switchOn -> Completable in
                if switchOn {
                    return self.notificationOnUseCase.excute(type: .challenge)
                } else {
                    return self.notificationOffUseCase.excute(type: .challenge)
                }
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        input.notification.asObservable()
            .flatMap { switchOn -> Completable in
                if switchOn {
                    return self.notificationOnUseCase.excute(type: .notice)
                } else {
                    return self.notificationOffUseCase.excute(type: .notice)
                }
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        input.cheeringNotification.asObservable()
            .flatMap { switchOn -> Completable in
                if switchOn {
                    return self.notificationOnUseCase.excute(type: .cheering)
                } else {
                    return self.notificationOffUseCase.excute(type: .cheering)
                }
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        input.challengeSuccess.asObservable()
            .flatMap { switchOn -> Completable in
                if switchOn {
                    return self.notificationOnUseCase.excute(type: .challengeSuccess)
                } else {
                    return self.notificationOffUseCase.excute(type: .challengeSuccess)
                }
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        input.challegeExpiration.asObservable()
            .flatMap { switchOn -> Completable in
                if switchOn {
                    return self.notificationOnUseCase.excute(type: .challengeExpiration)
                } else {
                    return self.notificationOffUseCase.excute(type: .challengeExpiration)
                }
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        return Output(notificationStatus: notificationStatus)
    }
}
