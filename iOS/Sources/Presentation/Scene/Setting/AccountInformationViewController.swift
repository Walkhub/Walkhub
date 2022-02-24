import UIKit

import SnapKit
import Then

class AccountInformationViewController: UIViewController {

    private let line = UIView().then {
        $0.backgroundColor = .gray200
    }

    private let accountInformationLabel = UILabel().then {
        $0.text = "계정 정보"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .color757575
    }

    private let idBtn = UIButton(type: .system).then {
        $0.setTitle("아이디", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.setTitleColor(.gray800, for: .normal)
        $0.contentHorizontalAlignment = .left
    }

    private let idLabel = UILabel().then {
        $0.textColor = .color757575
        $0.font = .notoSansFont(ofSize: 16, family: .regular)
    }

    private let phoneNumberBtn = UIButton(type: .system).then {
        $0.setTitle("전화번호", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.setTitleColor(.gray800, for: .normal)
        $0.contentHorizontalAlignment = .left
    }

    private let phoneNumberLabel = UILabel().then {
        $0.textColor = .color757575
        $0.font = .notoSansFont(ofSize: 16, family: .regular)
    }

    private let conditionsOfServiceBtn = UIButton(type: .system).then {
        $0.setTitle("서비스 이용 약관", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.setTitleColor(.gray800, for: .normal)
        $0.contentHorizontalAlignment = .left
    }

    private let personInformationBtn = UIButton(type: .system).then {
        $0.setTitle("개인정보 취급 방지", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.setTitleColor(.gray800, for: .normal)
        $0.contentHorizontalAlignment = .left
    }

    private let editAccountInformationLabel = UILabel().then {
        $0.text = "계정 정보 수정"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .color757575
    }

    private let changePasswordBtn = UIButton(type: .system).then {
        $0.setTitle("비밀번호 변경", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.setTitleColor(.gray800, for: .normal)
        $0.contentHorizontalAlignment = .left
    }

    private let outMemberShipBtn = UIButton(type: .system).then {
        $0.setTitle("회원탈퇴", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.setTitleColor(.red, for: .normal)
        $0.contentHorizontalAlignment = .left
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        demoData()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
    }

    private func demoData() {
        idLabel.text = "rlarldud"
        phoneNumberLabel.text = "010-2345-2342"
    }
}

// MARK: - Layout
extension AccountInformationViewController {
    private func addSubviews() {
        [line, accountInformationLabel, idBtn, idLabel, phoneNumberBtn, phoneNumberLabel,
        conditionsOfServiceBtn, personInformationBtn, editAccountInformationLabel,
         changePasswordBtn, outMemberShipBtn].forEach { view.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        line.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        accountInformationLabel.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom).offset(11)
            $0.leading.equalToSuperview().inset(16)
        }

        idBtn.snp.makeConstraints {
            $0.top.equalTo(accountInformationLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        idLabel.snp.makeConstraints {
            $0.centerY.equalTo(idBtn)
            $0.trailing.equalTo(idBtn.snp.trailing)
        }

        phoneNumberBtn.snp.makeConstraints {
            $0.top.equalTo(idBtn.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        phoneNumberLabel.snp.makeConstraints {
            $0.centerY.equalTo(phoneNumberBtn)
            $0.trailing.equalTo(phoneNumberBtn.snp.trailing)
        }

        conditionsOfServiceBtn.snp.makeConstraints {
            $0.top.equalTo(phoneNumberBtn.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        personInformationBtn.snp.makeConstraints {
            $0.top.equalTo(conditionsOfServiceBtn.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
    
        editAccountInformationLabel.snp.makeConstraints {
            $0.top.equalTo(personInformationBtn.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
        }

        changePasswordBtn.snp.makeConstraints {
            $0.top.equalTo(editAccountInformationLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        outMemberShipBtn.snp.makeConstraints {
            $0.top.equalTo(changePasswordBtn.snp.bottom)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
    }
}
