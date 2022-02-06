import UIKit

class MainPageTabBarController: UITabBarController {

    var defaultIndex = 0 {
        didSet {
            self.selectedIndex = defaultIndex
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .init(named: "F9F9F9")
        self.selectedIndex = defaultIndex
        setTabBarBackgroundColor()
        self.tabBar.unselectedItemTintColor = UIColor.gray

    }

    func setTabBarBackgroundColor() {
            tabBar.barTintColor = .init(named: "F9F9F9")
            tabBar.isTranslucent = false
        }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBar.tintColor = .black
    }
}
