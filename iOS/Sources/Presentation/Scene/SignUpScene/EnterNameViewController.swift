import UIKit

import SnapKit
import RxCocoa
import RxSwift
import RxFlow

class EnterNameViewController: UIViewController, Stepper {

    var steps = PublishRelay<Step>()
    var disposeBag = DisposeBag()

    private let infoLabel = UILabel().then {
        $0.text = "이름은 10글자 내로 입력해주세요."
        $0.textColor = .red
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
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

    let nameTextField = UITextField().then {
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
        setTextField()
        setButton()
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        infoLabel.isHidden = true
        setNavigation()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
        continueBtn.layer.masksToBounds = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setNavigation() {
        self.navigationController?.navigationBar.setBackButtonToX()
    }

    private func setTextField() {
        nameTextField.rx.text.orEmpty
            .subscribe(onNext: {
                if $0.count >= 2 && $0.count < 11 {
                    self.infoLabel.isHidden = true
                    self.continueBtn.isEnabled = true
                } else {
                    self.infoLabel.isHidden = false
                    self.continueBtn.isEnabled = false
                }
            }).disposed(by: disposeBag)
    }

    private func setButton() {
        continueBtn.rx.tap
            .map { WalkhubStep.certigyPhoneNumberIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
    }
}

// MARK: Layout
extension EnterNameViewController {
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
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52)
            $0.bottom.leading.trailing.equalToSuperview().inset(16)
        }

        infoLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
        }
    }
}
