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
        case .detailedChallengeIsRequired(let id):
            return navigateToDetailedChallengeScene(challengeId: id)
        case .participatingIsRequired(let id):
            return navigateToDetailedChallengeScene(challengeId: id)
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

    private func navigateToDetailedChallengeScene(challengeId: Int) -> FlowContributors {
        let challengeDetailViewController = conatinor.resolve(DetailedChallengeViewController.self)!
        self.rootViewController.pushViewController(challengeDetailViewController, animated: true)
        challengeDetailViewController.challengeId = challengeId
        return .one(flowContributor: .contribute(
            withNextPresentable: challengeDetailViewController,
            withNextStepper: challengeDetailViewController.viewModel
        ))
    }
    private func navigateToDetailedParticipatingScene(challengeId: Int) -> FlowContributors {
        let detailedParticipatingViewController = conatinor.resolve(ParticipatingViewController.self)!
        self.rootViewController.pushViewController(detailedParticipatingViewController, animated: true)
        detailedParticipatingViewController.challengeId = challengeId
        return .one(flowContributor: .contribute(
            withNextPresentable: detailedParticipatingViewController,
            withNextStepper: detailedParticipatingViewController.viewModel
        ))
    }
}
