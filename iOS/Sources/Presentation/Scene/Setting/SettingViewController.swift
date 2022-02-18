import UIKit

import SnapKit
import Then

class SettingViewController: UIViewController {

    private let line1 = UIView().then {
        $0.backgroundColor = .gray200
    }

    private let personalInformationLabel = UILabel().then {
        $0.text = "개인정보 설정"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .color757575
    }

    private let editProfileBtn = UIButton(type: .system).then {
        $0.setTitle("프로필 수정", for: .normal)
        $0.setTitleColor(.gray800, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.contentHorizontalAlignment = .left
    }

    private let editHealthInormationBtn = UIButton(type: .system).then {
        $0.setTitle("건강정보 수정", for: .normal)
        $0.setTitleColor(.gray800, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.contentHorizontalAlignment = .left
    }

    private let editLoginInformationBtn = UIButton(type: .system).then {
        $0.setTitle("로그인 정보 수정", for: .normal)
        $0.setTitleColor(.gray800, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.contentHorizontalAlignment = .left
    }

    private let editNotificationBtn = UIButton(type: .system).then {
        $0.setTitle("프로필 수정", for: .normal)
        $0.setTitleColor(.gray800, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.contentHorizontalAlignment = .left
    }

    private let line2 = UIView().then {
        $0.backgroundColor = .gray200
    }

    private let otherLabel = UILabel().then {
        $0.text = "기타"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .color757575
    }

    private let askBtn = UIButton(type: .system).then {
        $0.setTitle("문의하기", for: .normal)
        $0.setTitleColor(.gray800, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.contentHorizontalAlignment = .left
    }

    private let versionInformationBtn = UIButton(type: .system).then {
        $0.setTitle("버전 정보", for: .normal)
        $0.setTitleColor(.gray800, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.contentHorizontalAlignment = .left
    }

    private let versionLabel = UILabel().then {
        $0.text = "(1.0.0)"
        $0.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.textColor = .color616161
    }

    private let logOutBtn = UIButton(type: .system).then {
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(.gray800, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.contentHorizontalAlignment = .left
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
    }
}

// MARK: - Layout
extension SettingViewController {

    private func addSubviews() {
        [line1, personalInformationLabel, editProfileBtn, editHealthInormationBtn,
        editLoginInformationBtn, editNotificationBtn, line2, otherLabel,
        askBtn, versionInformationBtn, versionLabel, logOutBtn]
            .forEach { view.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        line1.snp.makeConstraints {
            $0.top.equalToSuperview().inset(56)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        personalInformationLabel.snp.makeConstraints {
            $0.top.equalTo(line1.snp.bottom).offset(11)
            $0.leading.equalToSuperview().inset(16)
        }

        editProfileBtn.snp.makeConstraints {
            $0.top.equalTo(personalInformationLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        editHealthInormationBtn.snp.makeConstraints {
            $0.top.equalTo(editProfileBtn.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        editLoginInformationBtn.snp.makeConstraints {
            $0.top.equalTo(editHealthInormationBtn.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        editNotificationBtn.snp.makeConstraints {
            $0.top.equalTo(editLoginInformationBtn.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        line2.snp.makeConstraints {
            $0.top.equalTo(editNotificationBtn.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        otherLabel.snp.makeConstraints {
            $0.top.equalTo(line2.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
        }

        askBtn.snp.makeConstraints {
            $0.top.equalTo(otherLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        versionInformationBtn.snp.makeConstraints {
            $0.top.equalTo(askBtn.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        versionLabel.snp.makeConstraints {
            $0.leading.equalTo(versionInformationBtn.snp.leading).offset(70)
            $0.centerY.equalTo(versionInformationBtn)
        }

        logOutBtn.snp.makeConstraints {
            $0.top.equalTo(versionInformationBtn.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
    }
}
