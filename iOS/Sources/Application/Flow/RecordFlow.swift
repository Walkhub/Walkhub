import UIKit

import RxFlow

class RecordFlow: Flow {

    private let container = AppDelegate.continer

    var root: Presentable {
        return rootViewController
    }

    private let rootViewController: RecordMeasurementViewController

    init() {
        self.rootViewController = container.resolve(RecordMeasurementViewController.self)!
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WalkhubStep else { return .none }

        switch step {
        case .recordMeasurementIsRequired:
            return navigateToRecordMeasurementScreen()
        case .playRecordIsRequired:
            return navigateToPlayRecordScreen()
        case .timerIsRequired:
            return navigateToTimerScreen()
        default:
            return .none
        }
    }

    private func navigateToRecordMeasurementScreen() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNextPresentable: rootViewController,
            withNextStepper: rootViewController.viewModel
        ))
    }

    private func navigateToPlayRecordScreen() -> FlowContributors {
        let playRecordViewController = container.resolve(PlayRecordViewController.self)!
        self.rootViewController.navigationController?.present(playRecordViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: playRecordViewController,
            withNextStepper: playRecordViewController.viewModel
        ))
    }

    private func navigateToTimerScreen() -> FlowContributors {
        let timerViewController = container.resolve(TimerViewController.self)!
        self.rootViewController.navigationController?.present(timerViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: timerViewController,
            withNextStepper: timerViewController.viewModel
        ))
    }

    

}
