import Foundation

import RxSwift
import RxCocoa
import Service

class DetailHubViewModel: ViewModelType {

    private let searchUserUseCase: SearchUserUseCase

    init(searchUserUseCase: SearchUserUseCase) {
        self.searchUserUseCase = searchUserUseCase
    }

    private var disposeBag = DisposeBag()

    struct Input {
        let name: Driver<String>
        let schoolId: Driver<Int>
        let dateType: Driver<DateType>
    }

    struct Output {
        let userList: PublishRelay<[User]>
    }

    func transform(_ input: Input) -> Output {
        let userList = PublishRelay<[User]>()
        let info = Driver.combineLatest(input.name, input.schoolId, input.dateType)

        input.name.asObservable().withLatestFrom(info).flatMap { name, id, type in
            self.searchUserUseCase.excute(schoolId: id, name: name, dateType: type)
        }.subscribe(onNext: {
            userList.accept($0)
        }).disposed(by: disposeBag)

        return Output(userList: userList)
    }
}
