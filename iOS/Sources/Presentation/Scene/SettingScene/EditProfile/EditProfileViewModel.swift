import Foundation

import RxSwift
import RxCocoa
import RxFlow
import Service

class EditProfileViewModel: ViewModelType, Stepper {

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
        let schoolId: Driver<Int>
        let buttonDidTap: Driver<Void>
        let search: Driver<String>
        let cellDidSelected: Driver<IndexPath>
    }

    struct Output {
        let profile: PublishRelay<UserProfile>
        let searchSchool: BehaviorRelay<[SearchSchool]>
        let schoolInfo: PublishRelay<SearchSchool>
    }

    func transform(_ input: Input) -> Output {
        let profile = PublishRelay<UserProfile>()
        let searchSchool = BehaviorRelay<[SearchSchool]>(value: [])
        let schoolIinfo = PublishRelay<SearchSchool>()

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

        input.schoolId.asObservable()
            .subscribe(onNext: {
                self.schoolId = $0
            }).disposed(by: disposeBag)

        input.search.asObservable()
            .flatMap {
                self.searchSchoolUseCase.excute(name: $0)
            }.subscribe(onNext: {
                searchSchool.accept($0)
            }).disposed(by: disposeBag)

        input.cellDidSelected.asObservable()
            .subscribe(onNext: { index in
                let value = searchSchool.value
                schoolIinfo.accept(value[index.row])
                self.schoolId = value[index.row].id
            }).disposed(by: disposeBag)

        return Output(
            profile: profile,
            searchSchool: searchSchool,
            schoolInfo: schoolIinfo
        )
    }
}
