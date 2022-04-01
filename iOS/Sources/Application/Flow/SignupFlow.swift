import Foundation

import RxFlow
import UIKit

class SignupFlow: Flow {

    private let container  = AppDelegate.continer

    var root: Presentable {
        return rootViewController
    }

    private let rootViewController: EnterNameViewController
    private let signupViewController: SignUpViewController
    private let navigationController = UINavigationController()

    init() {
        self.rootViewController = container.resolve(EnterNameViewController.self)!
        self.signupViewController = container.resolve(SignUpViewController.self)!
    }

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WalkhubStep else { return .none }

        switch step {
        case .enterNameIsRequired:
            return navigateToEnterNameScene()
        case .certigyPhoneNumberIsRequired:
            return navigateToCertifyPhoneNumScene()
        case .authenticationNumberIsRequired(let phoneNumber):
            return navigateToAuthenticationNumberScene(phoneNumber: phoneNumber)
        case .enterIdRequired:
            return navigateToIdScene()
        case .setSchoolIsRequired:
            return navigateToSearchSchoolScene()
        case .agreeIsRequired:
            return navigateToAgreeTermsScene()
        case .serviceUseTermsIsRequired:
            return navigateToServiceUseTermsScene()
        case .enterHealthInfoIsRequired:
            return navigateToEnterHealthInfoScene()
        default:
            return .none
        }
    }

    private func navigateToEnterNameScene() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNext: rootViewController
        ))
    }

    private func navigateToCertifyPhoneNumScene() -> FlowContributors {
        let certifyPhoneNumberViewController = container.resolve(CertifyPhoneNumberViewController.self)!
        self.navigationController.pushViewController(
            certifyPhoneNumberViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: certifyPhoneNumberViewController,
            withNextStepper: signupViewController.viewModel
        ))
    }

    private func navigateToAuthenticationNumberScene(phoneNumber: String) -> FlowContributors {
        let auththenicationNumberViewController = container.resolve(AuthenticationNumberViewController.self)!
        auththenicationNumberViewController.phoneNumber.accept(phoneNumber)
        self.navigationController.pushViewController(
            auththenicationNumberViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: auththenicationNumberViewController,
            withNextStepper: signupViewController.viewModel
        ))
    }

    private func navigateToIdScene() -> FlowContributors {
        let idViewController = container.resolve(IDViewController.self)!
        self.navigationController.pushViewController(
            idViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: idViewController,
            withNextStepper: signupViewController.viewModel
        ))
    }

    private func navigateToSearchSchoolScene() -> FlowContributors {
        let searchSchoolViewController = container.resolve(SchoolRegistrationViewController.self)!
        self.navigationController.pushViewController(
            searchSchoolViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: searchSchoolViewController,
            withNextStepper: signupViewController.viewModel
        ))
    }

    private func navigateToAgreeTermsScene() -> FlowContributors {
        let agreeTermsViewController = container.resolve(AgreeTermsViewController.self)!
        self.navigationController.pushViewController(
            agreeTermsViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNext: agreeTermsViewController
        ))
    }

    private func navigateToServiceUseTermsScene() -> FlowContributors {
        let serviceUseTermsViewController = container.resolve(ServiceUseTermsViewController.self)!
        self.navigationController.pushViewController(
            serviceUseTermsViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNext: serviceUseTermsViewController
        ))
    }

    private func navigateToEnterHealthInfoScene() -> FlowContributors {
        let enterHealthInfoViewController = container.resolve(EnterNameViewController.self)!
        self.navigationController.pushViewController(
            enterHealthInfoViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: enterHealthInfoViewController,
            withNextStepper: signupViewController.viewModel
        ))
    }
}
