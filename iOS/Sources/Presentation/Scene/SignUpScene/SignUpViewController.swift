import UIKit

import SnapKit
import RxCocoa
import RxSwift

class SignUpViewController: UIViewController {

    var disposeBag = DisposeBag()

    enum NameRange {
        case over
        case under
        case normal
    }

    private func checkName(_ name: String) -> NameRange {
        if name.count > 10 {
            let index = name.index(name.startIndex, offsetBy: 11)
            self.nameTextField.text = String(name[..<index])

            return .over
        }
        if name.count < 2 {
            return .under
        }
        return .normal
    }

    private let infoLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let closeBtn = UIBarButtonItem().then {
        $0.image = .init(systemName: "xmark")
        $0.tintColor = .gray500
    }

    private let afterSignUpLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
        $0.text = "회원가입하고"
    }

    private let walkTogetherLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
        $0.text = "친구들과 함께 걷기"
    }

    private let enterNameLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.text = "먼저 본인의 이름을 입력해주세요."
        $0.textColor = .gray600
    }

    private let nameTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.gray400.cgColor
        $0.borderStyle = UITextField.BorderStyle.none
        $0.placeholder = "이름(2~10자)"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.addLeftPadding()
    }

    private let continueBtn = UIButton(type: .system).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("계속하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.setBackgroundColor(.primary400, for: .normal)
        $0.setBackgroundColor(.gray300, for: .disabled)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTextField()
        addSubviews()
        makeSubviewConstraints()
    }

    override func viewDidLayoutSubviews() {
        continueBtn.layer.masksToBounds = true
    }

    private func setNavigation() {
        navigationItem.leftBarButtonItem = closeBtn
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setTextField() {
        nameTextField.rx.text.orEmpty
        .map { $0 != "" }
        .bind(to: continueBtn.rx.isEnabled)
        .disposed(by: disposeBag)

        nameTextField.rx.text.orEmpty
            .map(checkName(_:))
            .subscribe(onNext: { eeee in
                switch eeee {
                case .over:
                    self.infoLabel.textColor = .red
                    self.infoLabel.text = "이름은 10자 내로 입력해주세요."
                    //                    self.nameTextField.resignFirstResponder()
                    self.continueBtn.isUserInteractionEnabled = false
                    self.continueBtn.isEnabled = false

                case .under:
                    self.infoLabel.textColor = .red
                    self.infoLabel.text = ""
                    self.continueBtn.isUserInteractionEnabled = true
                    self.continueBtn.isEnabled = false

                case .normal:
                    self.infoLabel.textColor = .green
                    self.infoLabel.text = ""
                    self.continueBtn.isUserInteractionEnabled = true
                    self.continueBtn.isEnabled = true
                }
            })
            .disposed(by: disposeBag)
    }
}

extension SignUpViewController {
    private func addSubviews() {
        [afterSignUpLabel, walkTogetherLabel, enterNameLabel, nameTextField, continueBtn, infoLabel]
            .forEach { view.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        afterSignUpLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(16)
        }

        walkTogetherLabel.snp.makeConstraints {
            $0.top.equalTo(afterSignUpLabel.snp.bottom).offset(1)
            $0.leading.equalToSuperview().inset(16)
        }

        enterNameLabel.snp.makeConstraints {
            $0.top.equalTo(walkTogetherLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
        }

        nameTextField.snp.makeConstraints {
            $0.top.equalTo(enterNameLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        continueBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(30)
        }

        infoLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
        }
    }
}
