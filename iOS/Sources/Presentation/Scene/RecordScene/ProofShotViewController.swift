import UIKit

class ProofShotViewController: UIViewController {

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
        // Do any additional setup after loading the view.
    }
}
extension ProofShotViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            myImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
