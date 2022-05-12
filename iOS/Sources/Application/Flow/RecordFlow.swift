import UIKit

import RxSwift
import RxFlow
import BackgroundTasks

class RecordFlow: Flow {

    private let container = AppDelegate.continer
    private let disposeBag = DisposeBag()

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
        case .snapShotIsRequired:
            return navigateToProofShotScene()
        case .measurementCompleteIsRequired(let image):
            return navigateToMeasurementScene(image: image)
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
        let timerViewController = container.resolve(TimerViewController.self)!.then {
            $0.modalPresentationStyle = .fullScreen
            $0.modalTransitionStyle = .crossDissolve
        }
        let playRecordViewController = container.resolve(PlayRecordViewController.self)!.then {
            $0.modalPresentationStyle = .fullScreen
            $0.modalTransitionStyle = .crossDissolve
        }
        self.rootViewController.navigationController?.present(timerViewController, animated: true)
        // TODO: stepper로 맹글기
        Observable<Int>.interval(.seconds(3), scheduler: MainScheduler.asyncInstance)
            .take(1)
            .subscribe(onNext: { _ in
                self.rootViewController.navigationController?.pushViewController(
                    playRecordViewController, animated: false
                )
                timerViewController.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        return .one(flowContributor: .contribute(
            withNextPresentable: playRecordViewController,
            withNextStepper: playRecordViewController.viewModel
        ))
    }

    private func navigateToProofShotScene() -> FlowContributors {
        let snapShotViewController = container.resolve(ProofShotViewController.self)!
        self.rootViewController.navigationController?.pushViewController(snapShotViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNext: snapShotViewController
        ))
    }

    private func navigateToMeasurementScene(image: UIImage) -> FlowContributors {
        let measurementCompleteViewController = container.resolve(MeasurementCompleteViewController.self)!
        measurementCompleteViewController.image = image
        self.rootViewController.navigationController?.pushViewController(measurementCompleteViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: measurementCompleteViewController,
            withNextStepper: measurementCompleteViewController.viewModel
        ))
    }
}
