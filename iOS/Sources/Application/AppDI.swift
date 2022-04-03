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
        self.register(ChallengeViewModel.self) { resolver in
            ChallengeViewModel(
                fetchChallengesListUseCase: resolver.resolve(FetchChallengesListUseCase.self)!,
                fetchJoinedChallengesUseCase: resolver.resolve(FetchJoinedChallengesUseCase.self)!
            )
        }
        self.register(DetailedChallengeViewModel.self) { resolver in
            DetailedChallengeViewModel(
                fetchChallengeDetailUseCase: resolver.resolve(FetchChallengeDetailUseCase.self)!,
                joinChallengeUseCase: resolver.resolve(JoinChallengesUseCase.self)!
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
        self.register(ChallengeViewController.self) { resolver in
            return ChallengeViewController().then {
                $0.viewModel = resolver.resolve(ChallengeViewModel.self)!
            }
        }
        self.register(DetailedChallengeViewController.self) { resolver in
            return DetailedChallengeViewController().then {
                $0.viewModel = resolver.resolve(DetailedChallengeViewModel.self)!
            }
        }
    }

}
