import UIKit

import RxFlow

class ProfileFlow: Flow {

    var root: Presentable {
        return rootViewController
    }

    private let rootViewController = UINavigationController()

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WalkhubStep else { return .none }

        switch step {
        case .profileIsRequired:
            return navigateToProfileScreen()
        default:
            return .none
        }
    }

    private func navigateToProfileScreen() -> FlowContributors {
        return .none
    }

}
