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
        case .certigyPhoneNumberIsRequired(let name):
            return navigateToCertifyPhoneNumScene(name)
        case .authenticationNumberIsRequired(let name, let phoneNumber):
            return navigateToAuthenticationNumberScene(name, phoneNumber)
        case .passwordIsRequired(let name, let phoneNumber, let authCode, let id):
            return navigateToEnterPasswordScene(name, phoneNumber, authCode, id)
        case .enterIdRequired(let name, let phoneNumber, let authCode):
            return navigateToIdScene(name, phoneNumber, authCode)
        case .setSchoolIsRequired(let name, let phoneNumber, let authCode, let id, let password):
            return navigateToSearchSchoolScene(name, phoneNumber, authCode, id, password)
        case .agreeIsRequired(let name, let phoneNumber, let authCode, let id, let password, let schoolid):
            return navigateToAgreeTermsScene(name, phoneNumber, authCode, id, password, schoolid)
        case .serviceUseTermsIsRequired:
            return navigateToServiceUseTermsScene()
        case .enterHealthInfoIsRequired:
            return navigateToEnterHealthInfoScene()
        case .loaf(let message, let state, let location):
            return showLoaf(message, state: state, location: location)
        case .tabsIsRequired:
            return navigateToHomeScene()
        default:
            return .none
        }
    }

    private func navigateToEnterNameScene() -> FlowContributors {
        return .one(flowContributor: .contribute(
            withNext: rootViewController
        ))
    }

    private func navigateToCertifyPhoneNumScene(_ name: String) -> FlowContributors {
        let certifyPhoneNumberViewController = container.resolve(CertifyPhoneNumberViewController.self)!
        certifyPhoneNumberViewController.name = name
        self.rootViewController.navigationController?.pushViewController(
            certifyPhoneNumberViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: certifyPhoneNumberViewController,
            withNextStepper: certifyPhoneNumberViewController.viewModel
        ))
    }

    private func navigateToAuthenticationNumberScene(_ name: String, _ phoneNumber: String) -> FlowContributors {
        let auththenicationNumberViewController = container.resolve(AuthenticationNumberViewController.self)!
        auththenicationNumberViewController.name = name
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

    private func navigateToIdScene(_ name: String, _ phoneNumber: String, _ authCode: String) -> FlowContributors {
        let idViewController = container.resolve(IDViewController.self)!
        idViewController.name = name
        idViewController.phoneNumber = phoneNumber
        idViewController.authCode = authCode
        rootViewController.navigationController?.pushViewController(
            idViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: idViewController,
            withNextStepper: idViewController.viewModel
        ))
    }

    private func navigateToEnterPasswordScene(
        _ name: String,
        _ phoneNumber: String,
        _ authCode: String,
        _ id: String
    ) -> FlowContributors {
        let enterPasswordViewController = container.resolve(EnterPasswordViewController.self)!
        enterPasswordViewController.name = name
        enterPasswordViewController.phoneNumber = phoneNumber
        enterPasswordViewController.authCode = authCode
        enterPasswordViewController.id = id
        rootViewController.navigationController?.pushViewController(
            enterPasswordViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNext: enterPasswordViewController
        ))
    }
    private func navigateToSearchSchoolScene(
        _ name: String,
        _ phoneNumber: String,
        _ authCode: String,
        _ id: String,
        _ password: String
    ) -> FlowContributors {
        let searchSchoolViewController = container.resolve(SchoolRegistrationViewController.self)!
        searchSchoolViewController.name = name
        searchSchoolViewController.phoneNumber = phoneNumber
        searchSchoolViewController.authCode = authCode
        searchSchoolViewController.id = id
        searchSchoolViewController.password = password
        rootViewController.navigationController?.pushViewController(
            searchSchoolViewController,
            animated: true
        )
        return .one(flowContributor: .contribute(
            withNextPresentable: searchSchoolViewController,
            withNextStepper: searchSchoolViewController.viewModel
        ))
    }

    private func navigateToAgreeTermsScene(
        _ name: String,
        _ phoneNumber: String,
        _ authCode: String,
        _ id: String,
        _ password: String,
        _ schoolId: Int
    ) -> FlowContributors {
        let agreeTermsViewController = container.resolve(AgreeTermsViewController.self)!
        agreeTermsViewController.name = name
        agreeTermsViewController.phoneNumber = phoneNumber
        agreeTermsViewController.authCode = authCode
        agreeTermsViewController.id = id
        agreeTermsViewController.password = password
        agreeTermsViewController.schoolId = schoolId
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

    private func navigateToHomeScene() -> FlowContributors {
        let tabsFlow = TabsFlow()

        Flows.use(tabsFlow, when: .created) { [weak self] root in
            root.modalPresentationStyle = .fullScreen
            root.modalTransitionStyle = .coverVertical
            DispatchQueue.main.async {
                self?.rootViewController.present(root, animated: true)
                Loaf("회원가입 성공!", state: .success, location: .bottom, sender: root).show()
            }
        }
        return .one(flowContributor: .contribute(
            withNextPresentable: tabsFlow,
            withNextStepper: OneStepper(withSingleStep: WalkhubStep.tabsIsRequired))
        )
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
