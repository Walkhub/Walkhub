import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class EditNotificationViewModel: ViewModelType, Stepper {

    private let fetchNotificationStatusUseCase: FetchNotificationStatusUseCase
    private let notificationOnUseCase: NotificationOnUseCase
    private let notificationOffUseCase: NotificationOffUseCase
    private let fetchProfileUseCase: FetchProfileUseCase

    init(
        fetchNotificationStatusUseCase: FetchNotificationStatusUseCase,
        notificationOnUseCase: NotificationOnUseCase,
        notificationOffUseCase: NotificationOffUseCase,
        fetchProfileUseCase: FetchProfileUseCase
    ) {
        self.fetchNotificationStatusUseCase = fetchNotificationStatusUseCase
        self.notificationOnUseCase = notificationOnUseCase
        self.notificationOffUseCase = notificationOffUseCase
        self.fetchProfileUseCase = fetchProfileUseCase
    }

    private var userId: Int = Int()
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
                    return self.notificationOnUseCase.excute(type: .challenge, userId: self.userId)
                } else {
                    return self.notificationOffUseCase.excute(type: .challenge, userId: self.userId)
                }
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        input.getData.asObservable()
            .flatMap {
                self.fetchProfileUseCase.excute()
            }.subscribe(onNext: {
                self.userId = $0.userID
            }).disposed(by: disposeBag)

        input.notification.asObservable()
            .flatMap { switchOn -> Completable in
                if switchOn {
                    return self.notificationOnUseCase.excute(type: .notice, userId: self.userId)
                } else {
                    return self.notificationOffUseCase.excute(type: .notice, userId: self.userId)
                }
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        input.cheeringNotification.asObservable()
            .flatMap { switchOn -> Completable in
                if switchOn {
                    return self.notificationOnUseCase.excute(type: .cheering, userId: self.userId)
                } else {
                    return self.notificationOffUseCase.excute(type: .cheering, userId: self.userId)
                }
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        input.challengeSuccess.asObservable()
            .flatMap { switchOn -> Completable in
                if switchOn {
                    return self.notificationOnUseCase.excute(type: .challengeSuccess, userId: self.userId)
                } else {
                    return self.notificationOffUseCase.excute(type: .challengeSuccess, userId: self.userId)
                }
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        input.challegeExpiration.asObservable()
            .flatMap { switchOn -> Completable in
                if switchOn {
                    return self.notificationOnUseCase.excute(type: .challengeExpiration, userId: self.userId)
                } else {
                    return self.notificationOffUseCase.excute(type: .challengeExpiration, userId: self.userId)
                }
            }.subscribe(onNext: { _ in
            }).disposed(by: disposeBag)

        return Output(notificationStatus: notificationStatus)
    }
}
