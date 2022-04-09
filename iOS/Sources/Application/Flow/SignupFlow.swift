import Foundation

import Loaf
import RxFlow

class SignupFlow: Flow {

    private let container  = AppDelegate.continer

    var root: Presentable {
        return rootViewController
    }

    private let rootViewController: EnterNameViewController

    init() {
        self.rootViewController = container.resolve(EnterNameViewController.self)!
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
        case .passwordIsRequired:
            return navigateToEnterPasswordScene()
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
        case .loaf(let message, let state, let location):
            return showLoaf(message, state: state, location: location)
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
        self.rootViewController.navigationController?.pushViewController(
            certifyPhoneNumberViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: certifyPhoneNumberViewController,
            withNextStepper: certifyPhoneNumberViewController.viewModel
        ))
    }

    private func navigateToAuthenticationNumberScene(phoneNumber: String) -> FlowContributors {
        let certifyPhoneNumberViewController = container.resolve(CertifyPhoneNumberViewController.self)!
        let auththenicationNumberViewController = container.resolve(AuthenticationNumberViewController.self)!
        auththenicationNumberViewController.phoneNumber = phoneNumber
        rootViewController.navigationController?.pushViewController(
            auththenicationNumberViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: auththenicationNumberViewController,
            withNextStepper: auththenicationNumberViewController.viewModel
        ))
    }

    private func navigateToIdScene() -> FlowContributors {
        let idViewController = container.resolve(IDViewController.self)!
        rootViewController.navigationController?.pushViewController(
            idViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: idViewController,
            withNextStepper: idViewController.viewModel
        ))
    }

    private func navigateToEnterPasswordScene() -> FlowContributors {
        let enterPasswordViewController = container.resolve(EnterPasswordViewController.self)!
        rootViewController.navigationController?.pushViewController(
            enterPasswordViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNext: enterPasswordViewController
        ))
    }
    private func navigateToSearchSchoolScene() -> FlowContributors {
        let searchSchoolViewController = container.resolve(SchoolRegistrationViewController.self)!
        rootViewController.navigationController?.pushViewController(
            searchSchoolViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: searchSchoolViewController,
            withNextStepper: searchSchoolViewController.viewModel
        ))
    }

    private func navigateToAgreeTermsScene() -> FlowContributors {
        let agreeTermsViewController = container.resolve(AgreeTermsViewController.self)!
        rootViewController.navigationController?.pushViewController(
            agreeTermsViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: agreeTermsViewController,
            withNextStepper: agreeTermsViewController.viewModel
        ))
    }

    private func navigateToServiceUseTermsScene() -> FlowContributors {
        let serviceUseTermsViewController = container.resolve(ServiceUseTermsViewController.self)!
        rootViewController.navigationController?.pushViewController(
            serviceUseTermsViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNext: serviceUseTermsViewController
        ))
    }

    private func navigateToEnterHealthInfoScene() -> FlowContributors {
        let enterHealthInfoViewController = container.resolve(EnterHealthInformationViewController.self)!
        rootViewController.navigationController?.pushViewController(
            enterHealthInfoViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: enterHealthInfoViewController,
            withNextStepper: enterHealthInfoViewController.viewModel
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
