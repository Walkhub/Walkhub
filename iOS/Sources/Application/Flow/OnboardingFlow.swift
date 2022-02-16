import UIKit

import RxFlow

class OnboardingFlow: Flow {

    private let container = AppDelegate.continer

    var root: Presentable {
        return self.rootViewController
    }

    private lazy var rootViewController = UINavigationController()

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WalkhubStep else { return .none }

        switch step {
        case .onboardingIsRequired:
            return navigationToOnboardingScreen()
        case .loginIsRequired:
            return navigationToLoginScreen()
        case .userIsLoggedIn:
            return navigationToSignupScreen()
        default:
            return .none
        }
    }

    private func navigationToOnboardingScreen() -> FlowContributors {
        let onboardingViewController = container.resolve(OnboardingViewController.self)!
        self.rootViewController.pushViewController(onboardingViewController, animated: false)
        return .one(flowContributor: .contribute(withNext: onboardingViewController))
    }

    private func navigationToLoginScreen() -> FlowContributors {
        return .none
    }

    private func navigationToSignupScreen() -> FlowContributors {
        return .none
    }

}
