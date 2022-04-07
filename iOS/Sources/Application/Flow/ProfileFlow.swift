import UIKit

import RxFlow

class ProfileFlow: Flow {

    private let container = AppDelegate.continer

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
        let profileViewController = container.resolve(MyPageViewController.self)!
        self.rootViewController.pushViewController(profileViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: profileViewController,
            withNextStepper: profileViewController.viewModel
        ))
    }
}
