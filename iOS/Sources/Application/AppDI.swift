// swiftlint:disable function_body_length

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
                fetchMyPageUseCase: resolver.resolve(FetchMyPageUseCase.self)!,
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
        self.register(AgreeTermsViewModel.self) { resolver in
            AgreeTermsViewModel(
                signupUseCase: resolver.resolve(SignupUseCase.self)!,
                signinUseCase: resolver.resolve(SigninUseCase.self)!
            )
        }
        self.register(CertifyPhoneNumberViewModel.self) { resolver in
            CertifyPhoneNumberViewModel(
                verificationPhoneUseCase: resolver.resolve(VerificationPhoneUseCase.self)!
            )
        }
        self.register(AuthenticationNumberViewModel.self) { resolver in
            AuthenticationNumberViewModel(
                checkVerificationCodeUseCase: resolver.resolve(CheckVerificationCodeUseCase.self)!
            )
        }
        self.register(IDViewModel.self) { resolver in
            IDViewModel(
                checkAccountIdUseCase: resolver.resolve(CheckAccountIdUseCase.self)!
            )
        }
        self.register(EnterHealthInformationViewModel.self) { resolver in
            EnterHealthInformationViewModel(
                setHealthInformationUseCase: resolver.resolve(SetHealthInformationUseCase.self)!
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
        self.register(AgreeTermsViewController.self) { resolver in
            return AgreeTermsViewController().then {
                $0.viewModel = resolver.resolve(AgreeTermsViewModel.self)!
            }
        }
        self.register(AuthenticationNumberViewController.self) { resolver in
            return AuthenticationNumberViewController().then {
                $0.viewModel = resolver.resolve(AuthenticationNumberViewModel.self)!
            }
        }
        self.register(CertifyPhoneNumberViewController.self) { resolver in
            return CertifyPhoneNumberViewController().then {
                $0.viewModel = resolver.resolve(CertifyPhoneNumberViewModel.self)!
            }
        }
        self.register(EnterHealthInformationViewController.self) { resolver in
            return EnterHealthInformationViewController().then {
                $0.viewModel = resolver.resolve(EnterHealthInformationViewModel.self)!
            }
        }
        self.register(EnterNameViewController.self) { _ in
            return EnterNameViewController()
        }
        self.register(IDViewController.self) { resolver in
            return IDViewController().then {
                $0.viewModel = resolver.resolve(IDViewModel.self)!
            }
        }
    }
}
