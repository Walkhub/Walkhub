import UIKit

extension UINavigationBar {
    func setBackButtonToX() {
        let XButton = UIImage(systemName: "xmark")
        self.backIndicatorImage = XButton
        self.backIndicatorTransitionMaskImage = XButton
        self.topItem?.title = ""
        self.tintColor = .gray500
    }
}
