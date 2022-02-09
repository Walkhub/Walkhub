import UIKit

import RxFlow

class ChallengeFlow: Flow {

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
        return .none
    }

}
