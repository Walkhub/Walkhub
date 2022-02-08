import UIKit

extension UIView {
    func roundCorners(cornerRadius: CGFloat, byRoundingCorners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: byRoundingCorners,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
