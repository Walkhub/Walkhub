import UIKit

import Then
import SnapKit
import RxSwift

class CertifyPhoneNumberViewController: UIViewController, UITextFieldDelegate {

    var disposeBag = DisposeBag()

    enum PhoneNumberRange {
        case over
        case under
        case normal
    }

    private func checkPhoneNumber(_ name: String) -> PhoneNumberRange {
        if name.count > 10 {
            let index = name.index(name.startIndex, offsetBy: 11)
            self.phoneNumberTextField.text = String(name[..<index])

            return .over
        }
        else if name.count < 11 && name.count > 0 {
            return .under
        }
        else {
            return .normal
        }
    }

    private let phoneNumberProgressBar = UIProgressView().then {
        $0.progressViewStyle = .bar
        $0.progressTintColor = .primary400
        $0.trackTintColor = .gray400
        $0.progress = 0.16
    }

    private let continueBtn = UIButton(type: .system).then {
        $0.setTitle("계속하기", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundColor(.primary400, for: .normal)
        $0.setBackgroundColor(.gray300, for: .disabled)
    }

    private let infoLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let backBtn = UIBarButtonItem().then {
        $0.image = .init(systemName: "arrow.backward")
        $0.tintColor = .gray500
    }

    private let certifyPhoneNumberLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
        $0.text = "전화번호 인증"
    }

    private let accessoryView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 72.0))

    private let phoneNumberTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.gray400.cgColor
        $0.borderStyle = UITextField.BorderStyle.none
        $0.placeholder = "전화번호"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.addLeftPadding()
        $0.keyboardType = .numberPad
    }

    private let selfCertificationLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.text = "본인인증을 위해 전화번호를 입력해주세요."
        $0.textColor = .gray600
    }

    private func setTextField() {
        phoneNumberTextField.rx.text.orEmpty
            .map(checkPhoneNumber(_:))
            .subscribe(onNext: { aaaa in
                switch aaaa {
                case .over:
                    self.infoLabel.textColor = .red
                    self.infoLabel.text = ""
                    self.continueBtn.isEnabled = true

                case .under:
                    self.infoLabel.textColor = .red
                    self.infoLabel.text = "올바른 전화번호를 입력해주세요."
                    self.continueBtn.isEnabled = false

                case .normal:
                    self.infoLabel.textColor = .red
                    self.infoLabel.text = ""
                    self.continueBtn.isEnabled = false
                }
            })
            .disposed(by: disposeBag)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTextField()
        phoneNumberTextField.inputAccessoryView = accessoryView
        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
    }

    private func setNavigation() {
        navigationItem.leftBarButtonItem = backBtn
    }

}

extension CertifyPhoneNumberViewController {
    private func addSubviews() {
        accessoryView.addSubview(continueBtn)
        [certifyPhoneNumberLabel, phoneNumberTextField, infoLabel, phoneNumberProgressBar, selfCertificationLabel]
            .forEach { view.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        certifyPhoneNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(16)
        }

        infoLabel.snp.makeConstraints {
            $0.top.equalTo(phoneNumberTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
        }

        phoneNumberProgressBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
            $0.trailing.leading.equalToSuperview()
        }

        selfCertificationLabel.snp.makeConstraints {
            $0.top.equalTo(certifyPhoneNumberLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
        }

        phoneNumberTextField.snp.makeConstraints {
            $0.top.equalTo(selfCertificationLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        continueBtn.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview()
        }
    }
}
