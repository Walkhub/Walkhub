import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class AccountInformationViewModel: ViewModelType, Stepper {
    private let fetchAccountInfoUseCase: FetchAccountInfoUseCase

    init(fetchAccountInfoUseCase: FetchAccountInfoUseCase) {
        self.fetchAccountInfoUseCase = fetchAccountInfoUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let getData: Driver<Void>
    let changePwButtonDidTap: Driver<Void>
    }

    struct Output {
        let accountInfo: PublishRelay<AccountInfo>
    }

    func transform(_ input: Input) -> Output {
        let accountInfo = PublishRelay<AccountInfo>()

        input.getData.asObservable()
            .flatMap {
                self.fetchAccountInfoUseCase.excute()
            }.subscribe(onNext: {
                accountInfo.accept($0)
            }).disposed(by: disposeBag)

        input.changePwButtonDidTap.asObservable()
            .map { WalkhubStep.checkPasswordScene }
            .bind(to: steps)
            .disposed(by: disposeBag)

        return Output(accountInfo: accountInfo)
    }
}
