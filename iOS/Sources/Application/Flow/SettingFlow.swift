
import UIKit

import RxFlow

class SettingFlow: Flow {

    private let container = AppDelegate.continer

    var root: Presentable {
        return rootViewController
    }

    private let rootViewController = UINavigationController()

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
        case .backEidtProfileScene(let schoolId, let schoolName):
            return navigateToPopEditProfileScene(schoolId: schoolId, schoolName: schoolName)
        default:
            return .none
        }
    }

    private func navigateToSettingScene() -> FlowContributors {
        let settingViewController = container.resolve(SettingViewController.self)!
        self.rootViewController.pushViewController(settingViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: settingViewController,
            withNextStepper: settingViewController.viewModel
        ))
    }

    private func navigateToEditProfileScene() -> FlowContributors {
        let editProfileViewController = container.resolve(EditProfileViewController.self)!
        self.rootViewController.pushViewController(editProfileViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: editProfileViewController,
            withNextStepper: editProfileViewController.viewModel
        ))
    }

    private func navigateToEditHealthInformationScene() -> FlowContributors {
        let editHealthInformationViewController = container.resolve(EditHealthInofrmationViewController.self)!
        self.rootViewController.pushViewController(editHealthInformationViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: editHealthInformationViewController,
            withNextStepper: editHealthInformationViewController.viewModel
        ))
    }

    private func navigateToAccountInformationScene() -> FlowContributors {
        let accountInformationViewController = container.resolve(AccountInformationViewController.self)!
        self.rootViewController.pushViewController(accountInformationViewController, animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: accountInformationViewController,
            withNextStepper: accountInformationViewController.viewModel
        ))
    }

    private func navigateToPopEditProfileScene(
        schoolId: Int,
        schoolName: String
    ) -> FlowContributors {
        let editProfileViewController = container.resolve(EditProfileViewController.self)!
        editProfileViewController.schoolId.accept(schoolId)
        editProfileViewController.schoolLabel.text = schoolName
        editProfileViewController.gradeClassLabel.text = "현재 소속 중인 반이 없어요."
        self.rootViewController.popViewController(animated: true)
        return .one(flowContributor: .contribute(
            withNextPresentable: editProfileViewController,
            withNextStepper: editProfileViewController.viewModel
        ))
    }
}
