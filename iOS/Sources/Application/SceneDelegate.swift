import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {

        guard let windowScence = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: windowScence)
        window?.windowScene = windowScence

        let tabBarController = MainPageTabBarController()

        let homeView = UINavigationController(rootViewController: MainPageViewController())

        tabBarController.viewControllers = [homeView]

        let homeViewItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)

        homeView.tabBarItem = homeViewItem

//        let rootViewController = ViewController()
//        let navigationController = UINavigationController(rootViewController: rootViewController)
//        let mainPageViewcontroller = ViewController()

        let navigationController = UINavigationController()
        navigationController.setViewControllers([MainPageViewController()], animated: true)
        window?.rootViewController = MainPageViewController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

}
