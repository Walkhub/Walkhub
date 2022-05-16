import UIKit

import RxFlow

class HubFlow: Flow {

    private let container = AppDelegate.continer

    var root: Presentable {
        return rootViewController
    }

    private let rootViewController = UINavigationController()

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WalkhubStep else { return .none }

        switch step {
        case .hubIsRequired:
            return navigateToHubScreen()
        case .detailHubIsRequired(let schoolId):
            return navigateToDetailHubScene(schoolId)
        default:
            return .none
        }
    }

    private func navigateToHubScreen() -> FlowContributors {
        let hubViewController = container.resolve(HubViewController.self)!
        self.rootViewController.pushViewController(hubViewController, animated: false)
        return .one(flowContributor: .contribute(
            withNextPresentable: hubViewController,
            withNextStepper: hubViewController.viewModel
        ))
    }

    private func navigateToDetailHubScene(_ schoolId: Int) -> FlowContributors {
        let detailHubViewController = container.resolve(DetailHubViewController.self)!
        detailHubViewController.schoolId = schoolId
        self.rootViewController.pushViewController(detailHubViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: detailHubViewController,
            withNextStepper: detailHubViewController.viewModel
        ))
    }
}
