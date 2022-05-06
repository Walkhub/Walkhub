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
        self.register(EditHealthInformationViewModel.self) { resolver in
            EditHealthInformationViewModel(
                fetchHealthInformationUseCase: resolver.resolve(FetchHealthInformationUseCase.self)!,
                editHealthInformationUseCase: resolver.resolve(EditHealthInformationUseCase.self)!
            )
        }
        self.register(SettingProfileViewModel.self) { resolver in
            SettingProfileViewModel(
                fetchProfileUseCase: resolver.resolve(FetchProfileUseCase.self)!,
                editProfileUseCase: resolver.resolve(EditProfileUseCase.self)!,
                postImageUseCase: resolver.resolve(PostImageUseCase.self)!,
                searchSchoolUseCase: resolver.resolve(SearchSchoolUseCase.self)!
            )
        }
        self.register(EditNotificationViewModel.self) { resolver in
            EditNotificationViewModel(
                notificationOnUseCase: resolver.resolve(NotificationOnUseCase.self)!,
                notificationOffUseCase: resolver.resolve(NotificationOffUseCase.self)!
                )
        }
        self.register(AgreeTermsViewModel.self) { resolver in
            AgreeTermsViewModel(
                signupUseCase: resolver.resolve(SignupUseCase.self)!
            )
        }
        self.register(CertifyPhoneNumberViewModel.self) { resolver in
            CertifyPhoneNumberViewModel(
                verificationPhoneUseCase: resolver.resolve(VerificationPhoneUseCase.self)!
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
        self.register(AuthenicationNumberViewModel.self) { resolver in
            AuthenicationNumberViewModel(
                checkVerificationCodeUseCase: resolver.resolve(CheckVerificationCodeUseCase.self)!,
                verificationPhoneUseCase: resolver.resolve(VerificationPhoneUseCase.self)!
            )
        }
        self.register(SchoolRegistrationViewModel.self) { resolver in
            SchoolRegistrationViewModel(
                searchSchoolUseCase: resolver.resolve(SearchSchoolUseCase.self)!
            )
        }
        self.register(CheckPasswordViewModel.self) { resolver in
            CheckPasswordViewModel(
                checkPasswordUseCase: resolver.resolve(CheckPasswordUseCase.self)!
            )
        }
        self.register(ChangePasswordViewModel.self) { resolver in
            ChangePasswordViewModel(
                changePasswordUseCase: resolver.resolve(ChangePasswordUseCase.self)!
            )
        }
        self.register(AccountInformationViewModel.self) { resolver in
            AccountInformationViewModel(
                fetchAccountInfoUseCase: resolver.resolve(FetchAccountInfoUseCase.self)!
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
                $0.rankVC = resolver.resolve(RankViewController.self)!
                $0.informationVC = resolver.resolve(InformationViewController.self)!
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
        self.register(AccountInformationViewController.self) { resolver in
            return AccountInformationViewController().then {
                $0.viewModel = resolver.resolve(AccountInformationViewModel.self)!
            }
        }
        self.register(EditProfileViewController.self) { resolver in
            return EditProfileViewController().then {
                $0.viewModel = resolver.resolve(SettingProfileViewModel.self)!
            }
        }
        self.register(SettingViewController.self) { _ in
            return SettingViewController()
        }
        self.register(EditProfileViewController.self) { resolver in
            return EditProfileViewController().then {
                $0.viewModel = resolver.resolve(SettingProfileViewModel.self)!
            }
        }
        self.register(SearchSchoolViewController.self) { _ in
            return SearchSchoolViewController()
        }
        self.register(EditNotificationViewController.self) { resolver in
            return EditNotificationViewController().then {
                $0.viewModel = resolver.resolve(EditNotificationViewModel.self)!
            }
        }
        self.register(AgreeTermsViewController.self) { resolver in
            return AgreeTermsViewController().then {
                $0.viewModel = resolver.resolve(AgreeTermsViewModel.self)!
            }
        }
        self.register(CertifyPhoneNumberViewController.self) { resolver in
            return CertifyPhoneNumberViewController().then {
                $0.viewModel = resolver.resolve(CertifyPhoneNumberViewModel.self)!
                $0.authenticationNumberViewController = resolver.resolve(AuthenticationNumberViewController.self)!
            }
        }
        self.register(AuthenticationNumberViewController.self) { _ in
            return AuthenticationNumberViewController()
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
        self.register(AuthenticationNumberViewController.self) { resolver in
            return AuthenticationNumberViewController().then {
                $0.viewModel = resolver.resolve(AuthenicationNumberViewModel.self)!
            }
        }
        self.register(EnterPasswordViewController.self) { _ in
            return EnterPasswordViewController()
        }
        self.register(SchoolRegistrationViewController.self) { resolver in
            return SchoolRegistrationViewController().then {
                $0.viewModel = resolver.resolve(SchoolRegistrationViewModel.self)!
            }
        }
        self.register(CheckPasswordViewController.self) { resolver in
            return CheckPasswordViewController().then {
                $0.viewModel = resolver.resolve(CheckPasswordViewModel.self)!
            }
        }
        self.register(ChangePasswordViewController.self) { resolver in
            return ChangePasswordViewController().then {
                $0.viewModel = resolver.resolve(ChangePasswordViewModel.self)!
            }
        }
    }
}
