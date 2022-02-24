import UIKit

import RxFlow

class AppFlow: Flow {

    var root: Presentable {
        return rootViewController
    }

    private lazy var rootViewController: UIViewController = {
        let launchScreenStoryboard = UIStoryboard(name: "LaunchScreen", bundle: nil)
        let launchScreen = launchScreenStoryboard.instantiateViewController(withIdentifier: "LaunchScreen")
        return launchScreen
    }()

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WalkhubStep else { return .none }

        switch step {
        case .tabsIsRequired:
            return navigationToTabsScreen()
        case .onboardingIsRequired:
            return navigationToOnboardingScreen()
        default:
            return .none
        }
    }

}

extension AppFlow {

    private func navigationToTabsScreen() -> FlowContributors {

        let tabsFlow = TabsFlow()

        Flows.use(tabsFlow, when: .created) { [weak self] root in
            root.modalPresentationStyle = .fullScreen
            root.modalTransitionStyle = .crossDissolve
            DispatchQueue.main.async {
                self?.rootViewController.present(root, animated: true)
            }
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: tabsFlow,
            withNextStepper: OneStepper(withSingleStep: WalkhubStep.tabsIsRequired))
        )

    }

    private func navigationToOnboardingScreen() -> FlowContributors {

        let onboardingFlow = OnboardingFlow()

        Flows.use(onboardingFlow, when: .created) { [weak self] root in
            root.modalPresentationStyle = .fullScreen
            root.modalTransitionStyle = .crossDissolve
            DispatchQueue.main.async {
                self?.rootViewController.present(root, animated: true)
            }
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: onboardingFlow,
            withNextStepper: OneStepper(withSingleStep: WalkhubStep.onboardingIsRequired)
        ))

    }

}
