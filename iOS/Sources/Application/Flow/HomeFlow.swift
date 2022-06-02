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
        case .activityAnalysisIsRequired:
            return navigateToActivityAnalysisScreen()
        case .recordMeasurementIsRequired:
            return navigateToRecordMeasurementScreen()
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

    private func navigateToActivityAnalysisScreen() -> FlowContributors {
        let activityAnalysisViewController = container.resolve(ActivityAnalysisViewController.self)!
        self.rootViewController.pushViewController(activityAnalysisViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: activityAnalysisViewController,
            withNextStepper: activityAnalysisViewController.viewModel
        ))
    }

    private func navigateToRecordMeasurementScreen() -> FlowContributors {
        let recordFlow = RecordFlow()

        Flows.use(recordFlow, when: .created) { [weak self] root in
            self?.rootViewController.pushViewController(root, animated: true)
        }

        return .one(flowContributor: .contribute(
            withNextPresentable: recordFlow,
            withNextStepper: OneStepper(withSingleStep: WalkhubStep.recordMeasurementIsRequired)
        ))
    }

    private func navigateToNotificationListScene() -> FlowContributors {
        let notificationListViewController = container.resolve(NotificationListViewController.self)!
        self.rootViewController.pushViewController(notificationListViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: notificationListViewController,
            withNextStepper: notificationListViewController.viewModel
            ))
    }
}
