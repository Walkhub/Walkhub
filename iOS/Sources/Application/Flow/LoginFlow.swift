import UIKit

import RxFlow

class LoginFlow: Flow {

    var root: Presentable {
        return rootViewController
    }

    private let rootViewController = UINavigationController()

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WalkhubStep else { return .none }

        switch step {
        case .loginIsRequired:
            return navigateToLoginScreen()
        default:
            return .none
        }
    }

    private func navigateToLoginScreen() -> FlowContributors {
        return .none
    }

}
