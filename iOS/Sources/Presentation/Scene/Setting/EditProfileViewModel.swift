import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class EditProfileViewModel: ViewModelType, Stepper {

    private let fetchProfileUseCase: FetchProfileUseCase
    private let editProfileUseCase: EditProfileUseCase
    private let editSchoolUseCase: EditSchoolUseCase
    private let searchSchoolUseCase: SearchSchoolUseCase
    private let postImageUseCase: PostImageUseCase

    init(
        fetchProfileUseCase: FetchProfileUseCase,
        editProfileUseCase: EditProfileUseCase,
        editSchoolUseCase: EditSchoolUseCase,
        searchSchoolUseCase: SearchSchoolUseCase,
        postImageUseCase: PostImageUseCase
    ) {
        self.fetchProfileUseCase = fetchProfileUseCase
        self.editProfileUseCase = editProfileUseCase
        self.editSchoolUseCase = editSchoolUseCase
        self.searchSchoolUseCase = searchSchoolUseCase
        self.postImageUseCase = postImageUseCase
    }

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    struct Input {
        let getData: Driver<Void>
        let profileImage: Driver<[Data]>
        let name: Driver<String>
        let search: Driver<String>
        let cellTap: Signal<IndexPath>
        let buttonDidTap: Driver<Void>
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
        var schoolId = Int()
        var imageString = String()

        input.getData.asObservable().flatMap {
            self.fetchProfileUseCase.excute()
        }.subscribe(onNext: {
            profile.accept($0)
        }).disposed(by: disposeBag)

        input.name.asObservable().flatMap {
            self.searchSchoolUseCase.excute(name: $0)
        }.subscribe(onNext: {
            searchSchool.accept($0)
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

        input.buttonDidTap.asObservable().flatMap { _ in
            self.editSchoolUseCase.excute(schoolId: schoolId)
        }.subscribe(onNext: { _ in
        }).disposed(by: disposeBag)

        input.cellTap.asObservable().subscribe(onNext: { index in
            let value = searchSchool.value
            schoolInfo.accept(value[index.row])
            schoolId = value[index.row].id
        }).disposed(by: disposeBag)

        return Output(
            searchSchool: searchSchool,
            schoolInfo: schoolInfo,
            profile: profile
        )
    }
}
