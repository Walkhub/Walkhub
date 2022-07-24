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
        case .settingIsRequired:
            return navigateToSettingScreen()
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

    private func navigateToSettingScreen() -> FlowContributors {
        let settingFlow = SettingFlow()

        Flows.use(settingFlow, when: .created) { [weak self] root in
            self?.rootViewController.pushViewController(root, animated: true)
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: settingFlow,
            withNextStepper: OneStepper(withSingleStep: WalkhubStep.settingIsRequired)
        ))
    }
}
