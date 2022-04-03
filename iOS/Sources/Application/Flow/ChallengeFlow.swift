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
        default:
            return .none
        }
    }

    private func navigateToChallengeScreen() -> FlowContributors {
        let challengeViewController = conatinor.resolve(ChallengeViewController.self)!
        return .one(flowContributor: .contribute(
            withNextPresentable: challengeViewController,
            withNextStepper: challengeViewController.viewModel
        ))
    }

}
