import UIKit

import Loaf
import RxFlow

class LoginFlow: Flow {

    private let container = AppDelegate.continer

    var root: Presentable {
        return rootViewController
    }

    private let rootViewController: LoginViewController

    init() {
        self.rootViewController = container.resolve(LoginViewController.self)!
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WalkhubStep else { return .none }

        switch step {
        case .loginIsRequired:
            return navigateToLoginScreen()
        case .userIsLoggedIn:
            return navigationToTabsScreen()
        case .loaf(let message, let state, let location):
            return showLoaf(message, state: state, location: location)
        default:
            return .none
        }
    }

    private func navigateToLoginScreen() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: rootViewController.viewModel
        ))
    }

    private func navigationToTabsScreen() -> FlowContributors {

        let tabsFlow = TabsFlow()

        Flows.use(tabsFlow, when: .created) { [weak self] root in
            root.modalPresentationStyle = .fullScreen
            root.modalTransitionStyle = .coverVertical
            DispatchQueue.main.async {
                self?.rootViewController.present(root, animated: true)
                Loaf("로그인 성공!", state: .success, location: .bottom, sender: root).show()
            }
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: tabsFlow,
            withNextStepper: OneStepper(withSingleStep: WalkhubStep.tabsIsRequired))
        )

    }

    private func showLoaf(
        _ message: String,
        state: Loaf.State,
        location: Loaf.Location
    ) -> FlowContributors {
        Loaf(message, state: state, location: location, sender: self.rootViewController).show()
        return .none
    }

}
