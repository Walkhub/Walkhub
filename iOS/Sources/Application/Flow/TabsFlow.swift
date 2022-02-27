import UIKit

import RxFlow
import Then

class TabsFlow: Flow {

    var root: Presentable {
        return rootViewController
    }

    private let rootViewController = UITabBarController()

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? WalkhubStep else { return .none }

        switch step {
        case .tabsIsRequired:
            return navigateToTabsScreen()
        default:
            return .none
        }
    }

    private func navigateToTabsScreen() -> FlowContributors {

        let homeFlow = HomeFlow()
        let hubFlow = HubFlow()
        let challengeFlow = ChallengeFlow()
        let profileFlow = HubFlow()

        Flows.use(
            homeFlow, hubFlow, challengeFlow, profileFlow,
            when: .created
        ) { [weak self] root1, root2, root3, root4 in
            // TODO: tabBarItem image 설정
            let tabBarItem1 = UITabBarItem(title: "홈", image: UIImage(named: "HomeImg"), selectedImage: nil)
            let tabBarItem2 = UITabBarItem(title: "허브", image: UIImage(named: "HubImg"), selectedImage: nil)
            let tabBarItem3 = UITabBarItem(title: "챌린지", image: UIImage(named: "stepCountImg"), selectedImage: nil)
            let tabBarItem4 = UITabBarItem(title: "프로필", image: UIImage(named: "ProfileImg"), selectedImage: nil)
            root1.tabBarItem = tabBarItem1
            root2.tabBarItem = tabBarItem2
            root3.tabBarItem = tabBarItem3
            root4.tabBarItem = tabBarItem4
            self?.rootViewController.setViewControllers([root1, root2, root3, root4], animated: false)
        }

        return .multiple(flowContributors: [
            .contribute(withNextPresentable: homeFlow,
                        withNextStepper: OneStepper(withSingleStep: WalkhubStep.homeIsRequired)),
            .contribute(withNextPresentable: hubFlow,
                        withNextStepper: OneStepper(withSingleStep: WalkhubStep.hubIsRequired)),
            .contribute(withNextPresentable: challengeFlow,
                        withNextStepper: OneStepper(withSingleStep: WalkhubStep.challengeIsRequired)),
            .contribute(withNextPresentable: profileFlow,
                        withNextStepper: OneStepper(withSingleStep: WalkhubStep.profileIsRequired))
        ])
    }

}
