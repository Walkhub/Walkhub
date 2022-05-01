import UIKit

import Loaf
import RxFlow

class SettingFlow: Flow {

    private let container = AppDelegate.continer

    var root: Presentable {
        return rootViewController
    }

    private let rootViewController: SettingViewController

    init() {
        self.rootViewController = container.resolve(SettingViewController.self)!
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WalkhubStep else { return .none }

        switch step {
        case .settingIsRequired:
            return navigateToSettingScene()
        case .editProfileIsRequired:
            return navigateToEditProfileScene()
        case .editHealthInformationIsRequired:
            return navigateToEditHealthInformationScene()
        case .accountInformationIsRequired:
            return navigateToAccountInformationScene()
        case .backEditProfileScene:
            return navigateToBackEditProfileScene()
        case .searchSchoolIsRequired:
            return navigateToSearchSchoolScene()
        case .backToSettingScene:
            return backToSettingScene()
        case .loaf(let message, let state, let location):
            return showLoaf(message, state: state, location: location)
        default:
            return .none
        }
    }

    private func navigateToSettingScene() -> FlowContributors {
        return .one(flowContributor: .contribute(withNext: rootViewController))
    }

    private func navigateToEditProfileScene() -> FlowContributors {
        let editProfileViewController = container.resolve(EditProfileViewController.self)!
        self.rootViewController.navigationController?.pushViewController(editProfileViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: editProfileViewController,
            withNextStepper: editProfileViewController.viewModel
        ))
    }

    private func navigateToEditHealthInformationScene() -> FlowContributors {
        let editHealthInformationViewController = container.resolve(EditHealthInofrmationViewController.self)!
        self.rootViewController.navigationController?.pushViewController(
            editHealthInformationViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: editHealthInformationViewController,
            withNextStepper: editHealthInformationViewController.viewModel
        ))
    }

    private func navigateToAccountInformationScene() -> FlowContributors {
        let accountInformationViewController = container.resolve(AccountInformationViewController.self)!
        self.rootViewController.navigationController?.pushViewController(
            accountInformationViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: accountInformationViewController,
            withNextStepper: accountInformationViewController.viewModel
        ))
    }

    private func navigateToSearchSchoolScene() -> FlowContributors {
        let editProfileViewController = container.resolve(EditProfileViewController.self)!
        let searchSchoolViewController = container.resolve(SearchSchoolViewController.self)!
        rootViewController.navigationController?.pushViewController(searchSchoolViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: searchSchoolViewController,
            withNextStepper: editProfileViewController.viewModel
        ))
    }

    private func navigateToBackEditProfileScene() -> FlowContributors {
        let editProfileViewController = container.resolve(EditProfileViewController.self)!
        rootViewController.navigationController?.popViewController(animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: editProfileViewController,
            withNextStepper: editProfileViewController.viewModel
        ))
    }

    private func backToSettingScene() -> FlowContributors {
        rootViewController.navigationController?.popViewController(animated: true)
        return .one(flowContributor: .contribute(withNext: rootViewController))
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
