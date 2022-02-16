import UIKit

import RxFlow

class LoginFlow: Flow {

    private let container = AppDelegate.continer

    var root: Presentable {
        return rootViewController
    }

    private let rootViewController: LoginViewController

    init() {
        self.rootViewController = container.resolve(LoginViewController.self)!
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WalkhubStep else { return .none }

        switch step {
        case .loginIsRequired:
            return navigateToLoginScreen()
        case .userIsLoggedIn:
            return navigationToTabsScreen()
        default:
            return .none
        }
    }

    private func navigateToLoginScreen() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: rootViewController.viewModel
        ))
    }

    private func navigationToTabsScreen() -> FlowContributors {
        return .none
    }

}
