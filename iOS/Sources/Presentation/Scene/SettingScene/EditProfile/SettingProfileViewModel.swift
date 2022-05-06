import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class SettingProfileViewModel: ViewModelType, Stepper {

    private let fetchProfileUseCase: FetchProfileUseCase
    private let editProfileUseCase: EditProfileUseCase
    private let postImageUseCase: PostImageUseCase
    private let searchSchoolUseCase: SearchSchoolUseCase

    init(
        fetchProfileUseCase: FetchProfileUseCase,
        editProfileUseCase: EditProfileUseCase,
        postImageUseCase: PostImageUseCase,
        searchSchoolUseCase: SearchSchoolUseCase
    ) {
        self.fetchProfileUseCase = fetchProfileUseCase
        self.editProfileUseCase = editProfileUseCase
        self.postImageUseCase = postImageUseCase
        self.searchSchoolUseCase = searchSchoolUseCase
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
        let buttonDidTap: Driver<Void>
        let searchSchoolButton: Driver<Void>
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
                ).andThen(Single.just(WalkhubStep.backToSettingScene))
            }.bind(to: steps)
            .disposed(by: disposeBag)

        input.searchSchoolButton.asObservable()
            .map { WalkhubStep.searchSchoolIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        input.search.asObservable()
            .flatMap {
                self.searchSchoolUseCase.excute(name: $0)
            }.subscribe(onNext: {
                print($0)
                searchSchool.accept($0)
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
