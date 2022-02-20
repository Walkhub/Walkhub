import UIKit

import Then
import RxSwift
import SnapKit

class PWViewController: UIViewController {

    var disposeBag = DisposeBag()

    enum PWRange {
        case over
        case under
        case normal
        case middle
    }

    private func checkPW(_ password: String) -> PWRange {
        if password.count > 30 {
            let index = password.index(password.startIndex, offsetBy: 31)
            self.pwTextField.text = String(password[..<index])

            return .over
        } else if password.count < 8 && password.count > 1 {
            return .under
        } else if password.count < 2 {
            return .middle
        } else {
            return .normal
        }
    }

    private let pwProgressBar = UIProgressView().then {
        $0.progressViewStyle = .bar
        $0.progressTintColor = .primary400
        $0.trackTintColor = .gray400
        $0.progress = 0.48
    }

    private let infoLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let secondInfoLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let backBtn = UIBarButtonItem().then {
        $0.image = .init(systemName: "arrow.backward")
        $0.tintColor = .gray500
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

    private let accessoryView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 72.0))

//    let regex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,50}"

    private let pwTextField = UITextField().then {
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
        addSubviews()
        makeSubviewConstraints()
        setNavigation()
        setTextField()
        pwTextField.inputAccessoryView = accessoryView
        // Do any additional setup after loading the view.
    }

    private func setNavigation() {
        navigationItem.leftBarButtonItem = backBtn
    }

    private func isVaildTest(str: String?) -> Bool {
        guard str != nil else { return false }

        let strRegEx = "[0-9]{3}"
        let pred = NSPredicate(format: "SELF MATCHES %@", strRegEx)

        return pred.evaluate(with: "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,30}")
    }

//    func validatePassword(_ input: String) -> Validation<String, String> {
//        let regex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,30}"
//        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
//        let isValid = predicate.evaluate(with: input)
//
//        if isValid {
//            return .valid(input)
//        } else {
//            return .invalid("invalid password")
//        }
//    }
    private func setTextField() {
        pwTextField.rx.text.orEmpty
            .map { $0 != "" }
            .bind(to: continueBtn.rx.isEnabled)
            .disposed(by: disposeBag)

        pwTextField.rx.text.orEmpty
            .map(checkPW(_:))
            .subscribe(onNext: { bbbb in
                switch bbbb {
                case .over:
                    self.infoLabel.textColor = .red
                    self.secondInfoLabel.textColor = .red
                    self.infoLabel.text = "비밀번호는 8~30자 내로"
                    self.secondInfoLabel.text = "특수문자를 1개 이상 포함하여 입력해주세요."
                    self.continueBtn.isEnabled = false

                case .under:
                    self.infoLabel.textColor = .red
                    self.secondInfoLabel.textColor = .red
                    self.infoLabel.text = "비밀번호는 8~30자 내로"
                    self.secondInfoLabel.text = "특수문자를 1개 이상 포함하여 입력해주세요."
                    self.continueBtn.isEnabled = false

                case .normal:
                    self.infoLabel.textColor = .green
                    self.infoLabel.text = ""
                    self.secondInfoLabel.text = ""
                    self.continueBtn.isEnabled = true

                case .middle:
                    self.continueBtn.isEnabled = false
                }
            })
            .disposed(by: disposeBag)
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            let utf8Char = string.cString(using: .utf8)
//            let isBackSpace = strcmp(utf8Char, "\\b")
//            if string.hasCharacters() || isBackSpace == -92{
//                return true
//            }
//            return false
//        }
}

extension PWViewController {
    private func addSubviews() {
        accessoryView.addSubview(continueBtn)
        [pwLabel, pwTextField, infoLabel, secondInfoLabel, pwProgressBar]
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

        secondInfoLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(1)
            $0.leading.equalToSuperview().inset(16)
        }

        pwProgressBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
            $0.trailing.leading.equalToSuperview()
        }
    }
}

//extension String {
//    func hasCharacters() -> Bool {
//            do {
//                let regex = try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*[!@#$%^&*()_+=-])", options: .caseInsensitive)
//                if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)){
//                    return true
//                }
//            } catch {
//                print(error.localizedDescription)
//                return false
//            }
//            return false
//        }
//}
