import UIKit

import SnapKit
import RxCocoa
import RxSwift

class EnterHealthInformationViewController: UIViewController {

    var disposeBag = DisposeBag()

    private let enterHealthInformationLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
        $0.text = "건강 정보 입력"
    }

    private let healthInformationLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.text = "더 정확한 걸음 분석을 위해 필요한 정보에요."
        $0.textColor = .gray600
    }

    private let enterInformationLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.text = "건강 정보는 아무에게도 공개되지 않아요."
        $0.textColor = .gray600
    }

    private let doLaterBtn = UIBarButtonItem().then {
        $0.title = "나중에 하기"
        $0.tintColor = .gray900
    }

    private let heightTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.gray400.cgColor
        $0.borderStyle = UITextField.BorderStyle.none
        $0.placeholder = "0"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.addLeftPadding()
        $0.keyboardType = .numberPad
    }

    private let weightTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.gray400.cgColor
        $0.borderStyle = UITextField.BorderStyle.none
        $0.placeholder = "0"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.addLeftPadding()
        $0.keyboardType = .numberPad
    }

    private let heightLabel = UILabel().then {
        $0.text = "cm"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let weightLabel = UILabel().then {
        $0.text = "kg"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let maleBtn = UIButton(type: .system).then {
        $0.setTitle("남성", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.setTitleColor(.gray800, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.layer.cornerRadius = 12
        $0.setBackgroundColor(.primary400, for: .selected)
        $0.setBackgroundColor(.gray50, for: .normal)
    }

    private let femaleBtn = UIButton(type: .system).then {
        $0.setTitle("여성", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.setTitleColor(.gray800, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.layer.cornerRadius = 12
        $0.setBackgroundColor(.primary400, for: .selected)
        $0.setBackgroundColor(.gray50, for: .normal)
    }

    private let completeBtn = UIButton(type: .system).then {
        $0.setTitle("완료하기", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundColor(.primary400, for: .normal)
        $0.setBackgroundColor(.gray300, for: .disabled)
        $0.layer.cornerRadius = 12
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeSubviewConstraints()
        setBtn()
        setNavigation()
        completeBtn.isEnabled = false
    }

    private func setNavigation() {
        navigationItem.rightBarButtonItem = doLaterBtn
    }

    override func viewDidLayoutSubviews() {
        completeBtn.layer.masksToBounds = true
        maleBtn.layer.masksToBounds = true
        femaleBtn.layer.masksToBounds = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setBtn() {
        maleBtn.rx.tap.subscribe(onNext: {
            if self.maleBtn.isSelected {
                self.maleBtn.isSelected = false
                self.completeBtn.isEnabled = false
            } else {
                self.maleBtn.isSelected = true
                self.femaleBtn.isSelected = false
                self.completeBtn.isEnabled = true
            }
        }).disposed(by: disposeBag)

        femaleBtn.rx.tap.subscribe(onNext: {
            if self.femaleBtn.isSelected {
                self.femaleBtn.isSelected = false
                self.completeBtn.isEnabled = false
            } else {
                self.maleBtn.isSelected = false
                self.femaleBtn.isSelected = true
                self.completeBtn.isEnabled = true
            }
        }).disposed(by: disposeBag)

        heightTextField.rx.text.orEmpty.map { $0 != "" }
        .bind(to: completeBtn.rx.isEnabled).disposed(by: disposeBag)

        weightTextField.rx.text.orEmpty.map { $0 != "" }
        .bind(to: completeBtn.rx.isEnabled).disposed(by: disposeBag)
    }
}

extension EnterHealthInformationViewController {
    private func addSubviews() {
        [enterHealthInformationLabel,
         healthInformationLabel,
         enterInformationLabel,
         heightTextField,
         weightTextField,
         heightLabel,
         weightLabel,
         maleBtn,
         femaleBtn,
         completeBtn
        ].forEach { view.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        enterHealthInformationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(16)
        }

        healthInformationLabel.snp.makeConstraints {
            $0.top.equalTo(enterHealthInformationLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
        }

        enterInformationLabel.snp.makeConstraints {
            $0.top.equalTo(healthInformationLabel.snp.bottom).offset(1)
            $0.leading.equalToSuperview().inset(16)
        }

        heightTextField.snp.makeConstraints {
            $0.top.equalTo(enterInformationLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        weightTextField.snp.makeConstraints {
            $0.top.equalTo(heightTextField.snp.bottom).offset(20)
            $0.height.equalTo(52)
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
        }

        heightLabel.snp.makeConstraints {
            $0.centerY.equalTo(heightTextField)
            $0.trailing.equalTo(heightTextField.snp.trailing).inset(20)
        }

        weightLabel.snp.makeConstraints {
            $0.centerY.equalTo(weightTextField)
            $0.trailing.equalTo(weightTextField.snp.trailing).inset(20)
        }

        maleBtn.snp.makeConstraints {
            $0.top.equalTo(weightTextField.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(52)
            $0.width.equalTo(180)
        }

        femaleBtn.snp.makeConstraints {
            $0.top.equalTo(weightTextField.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
            $0.width.equalTo(180)
        }

        completeBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(30)
        }
    }
}
