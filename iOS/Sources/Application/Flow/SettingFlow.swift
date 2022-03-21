import UIKit

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
        default:
            return .none
        }
    }

    private func navigateToSettingScene() -> FlowContributors {
        return .one(flowContributor: .contribute(withNext: rootViewController))
    }

    private func navigateToEditProfileScene() -> FlowContributors {
        let editProfileViewController = container.resolve(EditProfileViewController.self)!
        let settingProfileViewController = container.resolve(SettingProfileViewController.self)!
        self.rootViewController.navigationController?.pushViewController(editProfileViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: editProfileViewController,
            withNextStepper: settingProfileViewController.viewModel
        ))
    }

    private func navigateToEditHealthInformationScene() -> FlowContributors {
        let editHealthInformationViewController = container.resolve(EditHealthInofrmationViewController.self)!
        self.rootViewController.navigationController?.pushViewController(editHealthInformationViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: editHealthInformationViewController,
            withNextStepper: editHealthInformationViewController.viewModel
        ))
    }

    private func navigateToAccountInformationScene() -> FlowContributors {
        let accountInformationViewController = container.resolve(AccountInformationViewController.self)!
        self.rootViewController.navigationController?.pushViewController(accountInformationViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: accountInformationViewController,
            withNextStepper: accountInformationViewController.viewModel
        ))
    }

    private func navigateToSearchSchoolScene() -> FlowContributors {
        let editProfileViewController = container.resolve(EditProfileViewController.self)!
        let searchSchoolViewController = container.resolve(SearchSchoolViewController.self)!
        let settingProfileViewController = container.resolve(SettingProfileViewController.self)!
        editProfileViewController.navigationController?.pushViewController(searchSchoolViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: searchSchoolViewController,
            withNextStepper: settingProfileViewController.viewModel
        ))
    }

    private func navigateToBackEditProfileScene() -> FlowContributors {
        let editProfileViewController = container.resolve(EditProfileViewController.self)!
        let settingProfileViewController = container.resolve(SettingProfileViewController.self)!
        let searchSchoolViewController = SearchSchoolViewController()
        searchSchoolViewController.navigationController?.popViewController(animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: editProfileViewController,
            withNextStepper: settingProfileViewController.viewModel
        ))
    }
}
