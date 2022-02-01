import Foundation
import UIKit
import SwiftUI

extension UIFont {
    enum Family: String {
        case regular = "Regular"
        case medium = "Medium"
        case bold = "Bold"
    }

    static func setFont(size: CGFloat, family: Family) -> UIFont {
        return UIFont(name: "NotoSansCJKkr-\(family.rawValue)", size: size)!
    }
}
