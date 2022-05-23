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
        case .detailHubIsRequired(let schoolId, let schoolName, let isMySchool):
            return navigateToDetailHubScene(schoolId, schoolName, isMySchool)
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

    private func navigateToDetailHubScene(
        _ schoolId: Int,
        _ schoolName: String,
        _ isMySchool: Bool
    ) -> FlowContributors {
        let detailHubViewController = container.resolve(DetailHubViewController.self)!
        detailHubViewController.schoolId = schoolId
        detailHubViewController.schoolName = schoolName
        detailHubViewController.isMySchool = isMySchool
        self.rootViewController.pushViewController(detailHubViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: detailHubViewController,
            withNextStepper: detailHubViewController.viewModel
        ))
    }
}
