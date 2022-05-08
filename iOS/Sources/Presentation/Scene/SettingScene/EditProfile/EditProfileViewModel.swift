import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class EditProfileViewModel: ViewModelType, Stepper {

    private let fetchProfileUseCase: FetchProfileUseCase
    private let editProfileUseCase: EditProfileUseCase
    private let postImageUseCase: PostImageUseCase

    init(
        fetchProfileUseCase: FetchProfileUseCase,
        editProfileUseCase: EditProfileUseCase,
        postImageUseCase: PostImageUseCase
    ) {
        self.fetchProfileUseCase = fetchProfileUseCase
        self.editProfileUseCase = editProfileUseCase
        self.postImageUseCase = postImageUseCase
    }

    private var disposeBag = DisposeBag()
    private var schoolId = Int()
    private var imageString = String()
    private var name = String()
    var steps = PublishRelay<Step>()

    struct Input {
        let getData: Driver<Void>
        let profileImage: Driver<[Data]>
        let name: Driver<String>
        let schoolId: Driver<Int>
        let buttonDidTap: Driver<Void>
        let searchSchoolButton: Driver<Void>
    }

    struct Output {
        let profile: PublishRelay<UserProfile>
    }

    func transform(_ input: Input) -> Output {
        let profile = PublishRelay<UserProfile>()

        input.getData.asObservable().flatMap {
            self.fetchProfileUseCase.excute()
        }.subscribe(onNext: {
            profile.accept($0)
            self.imageString = $0.profileImageUrl.absoluteString
            self.schoolId = $0.schoolId
            self.name = $0.name
        }).disposed(by: disposeBag)

        input.profileImage.asObservable().flatMap {
            self.postImageUseCase.excute(images: $0)
        }.subscribe(onNext: { data in
            print(data)
            self.imageString = data.first!
        }).disposed(by: disposeBag)

        input.name.asObservable()
            .subscribe(onNext: {
                self.name = $0
            }).disposed(by: disposeBag)

        input.buttonDidTap.asObservable()
            .flatMap { _ in
                return self.editProfileUseCase.excute(
                    name: self.name,
                    profileImageUrlString: self.imageString,
                    schoolId: self.schoolId
                ).andThen(Single.just(WalkhubStep.backToScene))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        input.searchSchoolButton.asObservable()
            .map { WalkhubStep.searchSchoolIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.schoolId.asObservable()
            .subscribe(onNext: {
                self.schoolId = $0
            }).disposed(by: disposeBag)

        return Output(
            profile: profile
        )
    }
}
