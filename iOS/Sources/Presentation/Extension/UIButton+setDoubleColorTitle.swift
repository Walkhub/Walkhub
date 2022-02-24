import UIKit

extension UIButton {
    func setDoubleColorTitle(
        string1: String, color1: UIColor,
        string2: String, color2: UIColor
    ) {
        let att = NSMutableAttributedString(string: "\(string1)\(string2)")
        att.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: color1,
            range: NSRange(location: 0, length: string1.count)
        )
        att.addAttribute(
            NSAttributedString.Key.foregroundColor,
            value: color2,
            range: NSRange(location: string1.count, length: string2.count)
        )
        self.setAttributedTitle(att, for: .normal)
    }
}
