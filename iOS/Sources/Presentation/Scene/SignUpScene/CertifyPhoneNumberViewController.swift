import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class CertifyPhoneNumberViewController: UIViewController {

    var authenticationNumberViewController: AuthenticationNumberViewController!
    var viewModel: CertifyPhoneNumberViewModel!
    var name = String()

    private var disposeBag = DisposeBag()

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
        $0.text = "올바른 전화번호를 입력해주세요."
        $0.textColor = .red
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
    let phoneNumberTextField = UITextField().then {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setTextField()
        bind()
        view.backgroundColor = .white
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSubviews()
        makeSubviewConstraints()
        phoneNumberTextField.inputAccessoryView = accessoryView
    }

    override func viewWillAppear(_ animated: Bool) {
        self.infoLabel.isHidden = true
        setNavigation()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    private func setNavigation() {
        navigationController?.navigationBar.setBackButtonToArrow()
    }

    private func setTextField() {
        phoneNumberTextField.keyboardType = .phonePad
        phoneNumberTextField.rx.text.orEmpty
            .subscribe(onNext: {
                self.phoneNumberTextField.text = $0.prettyPhoneNumber()
                self.infoLabel.isHidden = self.isValidPhone(phone: $0)
                self.continueBtn.isEnabled = self.isValidPhone(phone: $0)
            }).disposed(by: disposeBag)
    }

    private func isValidPhone(phone: String?) -> Bool {
        guard phone != nil else { return false }
        let str = phone?.replacingOccurrences(of: " ", with: "")

        let phoneRegEx = "^010([0-9]{4})([0-9]{4})"
        let pred = NSPredicate(format: "SELF MATCHES %@", phoneRegEx)
        return pred.evaluate(with: str)
    }

    private func bind() {
        let input = CertifyPhoneNumberViewModel.Input(
            phoneNumber: phoneNumberTextField.rx.text.orEmpty.asDriver(),
            continueButtonDidTap: continueBtn.rx.tap.asDriver(),
            name: name
        )

        _ = viewModel.transform(input)
    }
}

// MARK: Layout
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
