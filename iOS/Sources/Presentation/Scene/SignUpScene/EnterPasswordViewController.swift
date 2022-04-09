import UIKit

import Then
import SnapKit
import RxSwift
import RxCocoa
import RxFlow

class EnterPasswordViewController: UIViewController, Stepper {

    var steps = PublishRelay<Step>()
    private var disposeBag = DisposeBag()

    private let pwProgressBar = UIProgressView().then {
        $0.progressViewStyle = .bar
        $0.progressTintColor = .primary400
        $0.trackTintColor = .gray400
        $0.progress = 0.48
    }
    private let infoLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.numberOfLines = 2
        $0.text = """
비밀번호는 8~30자 내로
특수문자를 1개 이상 포함하여 입력해주세요.
"""
        $0.textColor = .red
    }
    private let pwLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
        $0.text = "비밀번호"
    }
    private let continueBtn = UIButton(type: .system).then {
        $0.setTitle("계속하기", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundColor(.primary400, for: .normal)
        $0.setBackgroundColor(.gray300, for: .disabled)
    }
    private let accessoryView = UIView(frame: CGRect(
        x: 0.0,
        y: 0.0,
        width: UIScreen.main.bounds.width,
        height: 72.0
    ))
    let pwTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.gray400.cgColor
        $0.borderStyle = UITextField.BorderStyle.none
        $0.placeholder = "비밀번호(8~30자,특수문자 1개 이상)"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.addLeftPadding()
        $0.isSecureTextEntry = true
        $0.keyboardType = .alphabet
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTextField()
        setButton()
        view.backgroundColor = .white
        pwTextField.inputAccessoryView = accessoryView
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSubviews()
        makeSubviewConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        infoLabel.isHidden = true
        continueBtn.isEnabled = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setNavigation() {
        navigationController?.navigationBar.setBackButtonToArrow()
    }

    private func setTextField() {
        pwTextField.rx.text.orEmpty
            .map { $0 != "" }
            .bind(to: continueBtn.rx.isEnabled)
            .disposed(by: disposeBag)

        pwTextField.rx.text.orEmpty
            .subscribe(onNext: {
                self.infoLabel.isHidden = self.isVaildTest(str: $0)
                self.continueBtn.isEnabled = self.isVaildTest(str: $0)
            }).disposed(by: disposeBag)
    }

    private func setButton() {
        continueBtn.rx.tap
            .map { WalkhubStep.setSchoolIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
    }

    private func isVaildTest(str: String?) -> Bool {
        guard str != nil else { return false }

        let strRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,30}"
        let pred = NSPredicate(format: "SELF MATCHES %@", strRegEx)

        return pred.evaluate(with: str)
    }

}

// MARK: Layout
extension EnterPasswordViewController {
    private func addSubviews() {
        accessoryView.addSubview(continueBtn)
        [pwLabel, pwTextField, infoLabel, pwProgressBar]
            .forEach { view.addSubview($0) }
    }
    private func makeSubviewConstraints() {

        pwLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(16)
        }
        pwTextField.snp.makeConstraints {
            $0.top.equalTo(pwLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(52)
            $0.centerX.equalToSuperview()
        }
        continueBtn.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview()
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(pwTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
        }
        pwProgressBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
            $0.trailing.leading.equalToSuperview()
        }
    }

}
