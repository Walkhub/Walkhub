import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow

class ProofShotViewController: UIViewController, Stepper {

    var steps = PublishRelay<Step>()
    var image = UIImage()
    private var disposeBag = DisposeBag()

    private let camera = UIImagePickerController().then {
        $0.sourceType = .camera
        $0.allowsEditing = true
        $0.cameraDevice = .rear
        $0.cameraCaptureMode = .photo
    }

    private let myImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        camera.delegate = self
        present(camera, animated: true, completion: nil)
    }
}
extension ProofShotViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            myImageView.image = image
            self.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
