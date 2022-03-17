import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class EditProfileViewModel: ViewModelType, Stepper {

    private let fetchProfileUseCase: FetchProfileUseCase
    private let editProfileUseCase: EditProfileUseCase
    private let editSchoolUseCase: EditSchoolUseCase
    private let postImageUseCase: PostImageUseCase

    init(
        fetchProfileUseCase: FetchProfileUseCase,
        editProfileUseCase: EditProfileUseCase,
        editSchoolUseCase: EditSchoolUseCase,
        postImageUseCase: PostImageUseCase
    ) {
        self.fetchProfileUseCase = fetchProfileUseCase
        self.editProfileUseCase = editProfileUseCase
        self.editSchoolUseCase = editSchoolUseCase
        self.postImageUseCase = postImageUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let getData: Driver<Void>
        let profileImage: Driver<[Data]>
        let name: Driver<String>
        let buttonDidTap: Driver<Void>
        let schoolId: Driver<Int>
    }

    struct Output {
        let searchSchool: BehaviorRelay<[SearchSchool]>
        let schoolInfo: PublishRelay<SearchSchool>
        let profile: PublishRelay<UserProfile>
    }

    func transform(_ input: Input) -> Output {
        let searchSchool = BehaviorRelay<[SearchSchool]>(value: [])
        let schoolInfo = PublishRelay<SearchSchool>()
        let profile = PublishRelay<UserProfile>()
        var imageString = String()

        input.getData.asObservable().flatMap {
            self.fetchProfileUseCase.excute()
        }.subscribe(onNext: {
            profile.accept($0)
        }).disposed(by: disposeBag)

        input.profileImage.asObservable().flatMap {
            self.postImageUseCase.excute(images: $0)
        }.subscribe(onNext: { data in
            imageString = (data.first?.absoluteString)!
        }).disposed(by: disposeBag)

        input.buttonDidTap.asObservable().withLatestFrom(input.name).flatMap {
            self.editProfileUseCase.excute(
                name: $0,
                profileImageUrlString: imageString
            )
        }.subscribe(onNext: {_ in
        }).disposed(by: disposeBag)

        input.buttonDidTap.asObservable().withLatestFrom(input.schoolId).flatMap {
            self.editSchoolUseCase.excute(schoolId: $0)
        }.subscribe(onNext: { _ in
        }).disposed(by: disposeBag)

        return Output(
            searchSchool: searchSchool,
            schoolInfo: schoolInfo,
            profile: profile
        )
    }
}
