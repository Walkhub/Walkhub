import UIKit

import RxFlow

class HomeFlow: Flow {

    private let container = AppDelegate.continer

    var root: Presentable {
        return rootViewController
    }

    private let rootViewController = UINavigationController()

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WalkhubStep else { return .none }

        switch step {
        case .homeIsRequired:
            return navigateToHomeScreen()
        default:
            return .none
        }
    }

    private func navigateToHomeScreen() -> FlowContributors {
        let homeViewController = container.resolve(HomeViewController.self)!
        self.rootViewController.pushViewController(homeViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: homeViewController,
            withNextStepper: homeViewController.viewModel
        ))
    }

}
