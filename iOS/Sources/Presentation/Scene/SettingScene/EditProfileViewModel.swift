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
    private let searchSchoolUseCase: SearchSchoolUseCase

    init(
        fetchProfileUseCase: FetchProfileUseCase,
        editProfileUseCase: EditProfileUseCase,
        editSchoolUseCase: EditSchoolUseCase,
        postImageUseCase: PostImageUseCase,
        searchSchoolUseCase: SearchSchoolUseCase
    ) {
        self.fetchProfileUseCase = fetchProfileUseCase
        self.editProfileUseCase = editProfileUseCase
        self.editSchoolUseCase = editSchoolUseCase
        self.postImageUseCase = postImageUseCase
        self.searchSchoolUseCase = searchSchoolUseCase
    }

    private var disposeBag = DisposeBag()
    private var schoolId = Int()
    var steps = PublishRelay<Step>()

    struct Input {
        let getData: Driver<Void>
        let profileImage: Driver<[Data]>
        let name: Driver<String>
        let buttonDidTap: Driver<Void>
        let search: Driver<String>
        let cellTap: Driver<IndexPath>
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

        input.buttonDidTap.asObservable().flatMap {
            self.editSchoolUseCase.excute(schoolId: self.schoolId)
        }.subscribe(onNext: { _ in
        }).disposed(by: disposeBag)

        input.cellTap.asObservable()
            .map { index -> Step in
                let value = searchSchool.value
                self.schoolId = value[index.row].id
                return WalkhubStep.backEditProfileScene
            }.bind(to: steps)
            .disposed(by: disposeBag)

        return Output(
            searchSchool: searchSchool,
            schoolInfo: schoolInfo,
            profile: profile
        )
    }
}
