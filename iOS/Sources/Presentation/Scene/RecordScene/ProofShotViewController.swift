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
    private let takePicture = PublishRelay<UIImage>()

    private let camera = UIImagePickerController().then {
        $0.sourceType = .camera
        $0.allowsEditing = true
        $0.cameraDevice = .rear
        $0.cameraCaptureMode = .photo
    }

    private let myImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        camera.delegate = self
        present(camera, animated: true, completion: nil)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }

    private func bind() {
        takePicture.asObservable()
            .debounce(.milliseconds(1), scheduler: MainScheduler.asyncInstance)
            .map { WalkhubStep.measurementCompleteIsRequired(image: $0) }
            .bind(to: steps)
            .disposed(by: disposeBag)
    }
}
extension ProofShotViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            myImageView.image = image
            self.image = image
            takePicture.accept(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
