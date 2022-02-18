import UIKit

import SnapKit
import Then

class EditProfileViewController: UIViewController {

    private let profileImgView = UIImageView().then {
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

    private let nameTextField = UITextField().then {
        $0.isEnabled = false
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let editNameBtn = UIButton(type: .system).then {
        $0.setImage(.init(systemName: "clock.fill"), for: .normal)
    }

    private let schoolInformationView = UIView().then {
        $0.layer.cornerRadius = 12
        $0.layer.borderColor = UIColor.colorBDBDBD.cgColor
        $0.layer.borderWidth = 1
    }

    private let schoolLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let gradeClassLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }

    private let editSchoolInformationBtn = UIButton(type: .system).then {
        $0.setImage(.init(systemName: "clock.fill"), for: .normal)
    }

    private let editBtn = UIButton(type: .system).then {
        $0.setBackgroundColor(.colorE0E0E0, for: .disabled)
        $0.setTitle("수정 완료", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundColor(.primary400, for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        demoData()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
        profileImgView.layer.cornerRadius = profileImgView.frame.size.height / 2
        editProfileImageBtn.layer.cornerRadius = editProfileImageBtn.frame.size.height / 2
    }

    private func demoData() {
        nameTextField.text = "김기영"
        schoolLabel.text = "대덕소프트웨어마이스터고등학교"
        gradeClassLabel.text = "2학년 1반"
    }
}

// MARK: - Layout
extension EditProfileViewController {
    private func addSubviews() {
        [profileImgView, editProfileImageBtn, nameView,
         schoolInformationView, editBtn].forEach { view.addSubview($0) }

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
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(52)
        }
    }
}
