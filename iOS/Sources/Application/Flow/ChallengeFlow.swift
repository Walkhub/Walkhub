import UIKit

import RxFlow

class ChallengeFlow: Flow {

    private let conatinor = AppDelegate.continer

    var root: Presentable {
        return rootViewController
    }

    private let rootViewController = UINavigationController()

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WalkhubStep else { return .none }

        switch step {
        case .challengeIsRequired:
            return navigateToChallengeScreen()
        case .detailedChallengeIsRequired:
            return navigateToDetailedChallengeScene()
        default:
            return .none
        }
    }

    private func navigateToChallengeScreen() -> FlowContributors {
        let challengeViewController = conatinor.resolve(ChallengeViewController.self)!
        self.rootViewController.pushViewController(challengeViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: challengeViewController,
            withNextStepper: challengeViewController.viewModel
        ))
    }

    private func navigateToDetailedChallengeScene() -> FlowContributors {
        let challengeDetailViewController = conatinor.resolve(DetailedChallengeViewController.self)!
        self.rootViewController.pushViewController(challengeDetailViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: challengeDetailViewController,
            withNextStepper: challengeDetailViewController.viewModel
        ))
    }
}
