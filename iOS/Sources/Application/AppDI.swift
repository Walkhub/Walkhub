import Foundation

import Service
import Swinject

extension Container {

    public func registerDependencies() {
        registerServiceDependencies()
        registerViewModel()
        registerViewController()
    }

    private func registerViewModel() {
        self.register(LoginViewModel.self) { resolver in
            LoginViewModel(signinUseCase: resolver.resolve(SigninUseCase.self)!)
        }
        self.register(HomeViewModel.self) { resolver in
            HomeViewModel(
                fetchCaloriesLevelUseCase: resolver.resolve(FetchCalroiesLevelUseCase.self)!,
                fetchLiveDailyExerciseRecordUseCase: resolver.resolve(FetchLiveDailyExerciseRecordUseCase.self)!,
                fetchExercisesAnalysisUseCase: resolver.resolve(FetchExerciseAnalysisUseCase.self)!,
                fetchRankPreviewUseCase: resolver.resolve(FetchRankPreviewUseCase.self)!
            )
        }
        self.register(HubViewModel.self) { resolver in
            HubViewModel(
                fetchSchoolUseCase: resolver.resolve(FetchSchoolRankUseCase.self)!,
                searchSchoolRankUseCase: resolver.resolve(SearchSchoolRankUseCase.self)!
            )
        }
        self.register(DetailHubViewModel.self) { resolver in
            DetailHubViewModel(
                searchUserUseCase: resolver.resolve(SearchUserUseCase.self)!,
                fetchUserSchoolRankUseCase: resolver.resolve(FetchUserSchoolRankUseCase.self)!,
                fetchUserRankUseCase: resolver.resolve(FetchUserRankUseCase.self)!,
                fetchSchoolDetailsUseCase: resolver.resolve(FetchSchoolDetailsUseCase.self)!
            )
        }
        self.register(ActivityAnalysisViewModel.self) { resolver in
            ActivityAnalysisViewModel(
                fetchCaloriesLevelUseCase: resolver.resolve(FetchCalroiesLevelUseCase.self)!,
                fetchLiveDailyExerciseRecordUseCase: resolver.resolve(FetchLiveDailyExerciseRecordUseCase.self)!,
                fetchExerciseAnalysisUseCase: resolver.resolve(FetchExerciseAnalysisUseCase.self)!,
                fetchWeekStepCountChartsUseCase: resolver.resolve(FetchWeekStepCountChartsUseCase.self)!,
                fetchMonthStepCountChartsUseCase: resolver.resolve(FetchMonthStepCountChartsUseCase.self)!
            )
        }
        self.register(MyPageViewModel.self) { resolver in
            MyPageViewModel(
                fetchMyPageUseCase: resolver.resolve(FetchProfileUseCase.self)!,
                fetchDailyExerciseUseCase: resolver.resolve(FetchLiveDailyExerciseRecordUseCase.self)!
            )
        }
        self.register(PlayRecordViewModel.self) { resolver in
            PlayRecordViewModel(
                fetchExerciseAnalysisUseCase: resolver.resolve(FetchExerciseAnalysisUseCase.self)!,
                fetchMeasuringExerciseUseCase: resolver.resolve(FetchMeasuringExerciseUseCase.self)!,
                fetchRecordExerciseUseCase: resolver.resolve(FetchRecordExerciseUseCase.self)!,
                endExerciseUseCase: resolver.resolve(EndExerciseUseCase.self)!
            )
        }
        self.register(RecordMeasurementViewModel.self) { resolver in
            RecordMeasurementViewModel(
                fetchExercisesListUseCase: resolver.resolve(FetchExercisesListUseCase.self)!,
                startExerciseUseCase: resolver.resolve(StartExerciseUseCase.self)!
            )
        }
        self.register(EditProfileViewModel.self) { resolver in
            EditProfileViewModel(
                fetchProfileUseCase: resolver.resolve(FetchProfileUseCase.self)!,
                editProfileUseCase: resolver.resolve(EditProfileUseCase.self)!,
                editSchoolUseCase: resolver.resolve(EditSchoolUseCase.self)!,
                postImageUseCase: resolver.resolve(PostImageUseCase.self)!
            )
        }
        self.register(EditHealthInformationViewModel.self) { resolver in
            EditHealthInformationViewModel(
                fetchHealthInformationUseCase: resolver.resolve(FetchHealthInformationUseCase.self)!,
                editHealthInformationUseCase: resolver.resolve(EditHealthInformationUseCase.self)!
            )
        }
        self.register(SearchSchoolViewModel.self) { resolver in
            SearchSchoolViewModel(
                searchSchoolUseCase: resolver.resolve(SearchSchoolUseCase.self)!
            )
        }
    }

    private func registerViewController() {
        self.register(OnboardingViewController.self) { _ in return OnboardingViewController() }
        self.register(LoginViewController.self) { resolver in
            return LoginViewController().then {
                $0.viewModel = resolver.resolve(LoginViewModel.self)!
            }
        }
        self.register(HomeViewController.self) { resolver in
            return HomeViewController().then {
                $0.viewModel = resolver.resolve(HomeViewModel.self)!
            }
        }
        self.register(HubViewController.self) { resolver in
            return HubViewController().then {
                $0.viewModel = resolver.resolve(HubViewModel.self)!
            }
        }
        self.register(DetailHubViewController.self) { resolver in
            return DetailHubViewController().then {
                $0.viewModel = resolver.resolve(DetailHubViewModel.self)!
            }
        }
        self.register(ActivityAnalysisViewController.self) { resolver  in
            return ActivityAnalysisViewController().then {
                $0.viewModel = resolver.resolve(ActivityAnalysisViewModel.self)!
            }
        }
        self.register(MyPageViewController.self) { resolver in
            return MyPageViewController().then {
                $0.viewModel = resolver.resolve(MyPageViewModel.self)!
            }
        }
        self.register(PlayRecordViewController.self) { resolver in
            return PlayRecordViewController().then {
                $0.viewModel = resolver.resolve(PlayRecordViewModel.self)!
            }
        }
        self.register(RecordMeasurementViewController.self) { resolver in
            return RecordMeasurementViewController().then {
                $0.viewModel = resolver.resolve(RecordMeasurementViewModel.self)!
            }
        }
        self.register(TimerViewController.self) { _ in
            return TimerViewController()
        }
        self.register(EditHealthInofrmationViewController.self) { resolver in
            return EditHealthInofrmationViewController().then {
                $0.viewModel = resolver.resolve(EditHealthInformationViewModel.self)!
            }
        }
        self.register(SettingViewController.self) { resolver in
            return SettingViewController().then {
                $0.viewModel = resolver.resolve(SettingViewModel.self)!
            }
        }
        self.register(AccountInformationViewController.self) { resolver in
            return AccountInformationViewController().then {
                $0.viewModel = resolver.resolve(AccountInformationViewModel.self)!
            }
        }
        self.register(EditProfileViewController.self) { resolver in
            return EditProfileViewController().then {
                $0.viewModel = resolver.resolve(EditProfileViewModel.self)!
            }
        }
        self.register(SearchSchoolViewController.self) { resolver in
            return SearchSchoolViewController().then {
                $0.viewModel = resolver.resolve(SearchSchoolViewModel.self)!
            }
        }
    }

}
