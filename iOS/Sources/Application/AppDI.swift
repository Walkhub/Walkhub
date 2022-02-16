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
    }

}
