import UIKit

extension UINavigationBar {
    func setBackButtonToArrow() {
        let XButton = UIImage(systemName: "arrow.backward")
        self.backIndicatorImage = XButton
        self.backIndicatorTransitionMaskImage = XButton
        self.topItem?.title = ""
        self.tintColor = .gray500
    }
}
