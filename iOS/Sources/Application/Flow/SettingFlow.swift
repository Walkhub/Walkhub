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
        case .checkPasswordScene:
            return navigateToCheckScene()
        case .changePasswordScene(let password):
            return navigateToChangePasswordScene(password: password)
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
        return .none
    }

    private func navigateToCheckScene() -> FlowContributors {
        let checkPasswordViewController = container.resolve(CheckPasswordViewController.self)!
        rootViewController.navigationController?.pushViewController(
            checkPasswordViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: checkPasswordViewController,
            withNextStepper: checkPasswordViewController.viewModel
            ))
    }

    private func navigateToChangePasswordScene(password: String) -> FlowContributors {
        let changePasswordViewController = container.resolve(ChangePasswordViewController.self)!
        changePasswordViewController.currentPassword = password
        rootViewController.navigationController?.pushViewController(
            changePasswordViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: changePasswordViewController,
            withNextStepper: changePasswordViewController.viewModel
            ))
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
