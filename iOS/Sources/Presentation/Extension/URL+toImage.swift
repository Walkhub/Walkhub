import UIKit

extension URL {
    func toImage() -> UIImage {
        let data = (try? Data(contentsOf: self))!
        return UIImage.init(data: data) ?? UIImage()
    }
}
