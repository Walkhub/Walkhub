import UIKit

import RxFlow

class HubFlow: Flow {

    var root: Presentable {
        return rootViewController
    }

    private let rootViewController = UINavigationController()

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WalkhubStep else { return .none }

        switch step {
        case .hubIsRequired:
            return navigateToHubScreen()
        default:
            return .none
        }
    }

    private func navigateToHubScreen() -> FlowContributors {
        return .none
    }

}
