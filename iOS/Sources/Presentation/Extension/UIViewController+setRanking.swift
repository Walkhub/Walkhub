import Foundation
import UIKit

extension UIViewController {
    func setRanking(_ ranking: Int, _ imageView: UIImageView) {
        switch ranking {
        case 1:
            imageView.image = UIImage.init(named: "GoldBadgeImg")
        case 2:
            imageView.image = UIImage.init(named: "SilverBadgeImg")
        case 3:
            imageView.image = UIImage.init(named: "BronzeBadgeImg")
        default:
            imageView.image = UIImage()
        }
    }
}
