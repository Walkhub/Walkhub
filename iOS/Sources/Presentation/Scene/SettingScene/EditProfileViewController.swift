import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class EditProfileViewController: UIViewController {

    var viewModel: EditProfileViewModel!
    let getData = PublishRelay<Void>()
    let image = PublishRelay<[Data]>()

    private let imagePickerView = UIImagePickerController()
    private var disposeBag = DisposeBag()
    private var profileName: String = ""

    private let alertBackView = UIView().then {
        $0.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
    }

    private let alert = CustomAlert().then {
        $0.setup(
            title: "학교 변경 시 기존 소속 중인 반에서\n자동 탈퇴됩니다.",
            cancel: "안하기",
            ok: "변경하기")
    }

    let profileImgView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .colorE0E0E0
    }

    private let editProfileImageBtn = UIButton(type: .system).then {
        $0.backgroundColor = .clear
        $0.setImage(.init(systemName: "camera.fill"), for: .normal)
        $0.tintColor = .black
    }

    private let nameView = UIView().then {
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.colorBDBDBD.cgColor
    }

    let nameTextField = UITextField().then {
        $0.isEnabled = false
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let editNameBtn = UIButton(type: .system).then {
        $0.tintColor = .black
        $0.setImage(.init(named: "editImg"), for: .normal)
    }

    private let schoolInformationView = UIView().then {
        $0.layer.cornerRadius = 12
        $0.layer.borderColor = UIColor.colorBDBDBD.cgColor
        $0.layer.borderWidth = 1
    }

    let schoolLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    let gradeClassLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }

    let editSchoolInformationBtn = UIButton(type: .system).then {
        $0.tintColor = .black
        $0.setImage(.init(named: "editImg"), for: .normal)
    }

    let editBtn = UIButton(type: .system).then {
        $0.setBackgroundColor(.colorE0E0E0, for: .disabled)
        $0.setTitle("수정 완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundColor(.primary400, for: .normal)
        $0.layer.cornerRadius = 12
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerView.delegate = self
        nameTextField.delegate = self
        setBtn()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
        profileImgView.layer.cornerRadius = profileImgView.frame.size.height / 2
        editProfileImageBtn.layer.cornerRadius = editProfileImageBtn.frame.size.height / 2
    }

    override func viewWillAppear(_ animated: Bool) {
        alertBackView.isHidden = true
        alert.isHidden = true
        editBtn.isEnabled = false
    }

    private func setBtn() {
        editProfileImageBtn.rx.tap.subscribe(onNext: {
            self.openPhotoLibrary()
        }).disposed(by: disposeBag)

        editNameBtn.rx.tap.subscribe(onNext: {
            self.nameTextField.isEnabled = true
            self.nameTextField.becomeFirstResponder()
        }).disposed(by: disposeBag)
    }
}

// MARK: - Layout
extension EditProfileViewController {
    private func addSubviews() {
        [profileImgView, editProfileImageBtn, nameView,
         schoolInformationView, editBtn, alertBackView, alert]
            .forEach { view.addSubview($0) }

        [nameTextField, editNameBtn].forEach { nameView.addSubview($0) }

        [schoolLabel, gradeClassLabel, editSchoolInformationBtn]
            .forEach { schoolInformationView.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        profileImgView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(80)
        }

        editProfileImageBtn.snp.makeConstraints {
            $0.edges.equalTo(profileImgView)
        }

        nameView.snp.makeConstraints {
            $0.top.equalTo(editProfileImageBtn.snp.bottom).offset(24)
            $0.left.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        nameTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        editNameBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }

        schoolInformationView.snp.makeConstraints {
            $0.top.equalTo(nameView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(64)
        }

        schoolLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(11)
            $0.leading.equalToSuperview().inset(16)
        }

        gradeClassLabel.snp.makeConstraints {
            $0.top.equalTo(schoolLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(16)
        }

        editSchoolInformationBtn.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }

        editBtn.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        alertBackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        alert.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(296)
            $0.height.equalTo(148)
        }
    }
}

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private func openPhotoLibrary() {
        imagePickerView.sourceType = .photoLibrary
        present(imagePickerView, animated: false, completion: nil)
    }

    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let profileImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImgView.image = profileImage
            let profileImages = [profileImage.jpegData(compressionQuality: 1.0)!]
            image.accept(profileImages)
        }
        editBtn.isEnabled = true

        imagePickerView.dismiss(animated: true, completion: nil)
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.isEnabled = false
        if profileName != textField.text {
            editBtn.isEnabled = true
        }
    }
}

