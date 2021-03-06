import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class AuthenticationNumberViewController: UIViewController {

    var name = String()
    var phoneNumber = String()
    var viewModel: AuthenicationNumberViewModel!

    private var disposeBag = DisposeBag()
    private var isRunningTimer: Bool = false
    private var timerValue = 300

    private let timerLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .primary400
    }
    let checkBtn = UIButton().then {
        $0.setImage(UIImage.init(systemName: "square"), for: .normal)
        $0.tintColor = .gray600
        $0.setImage(UIImage.init(systemName: "checkmark.square"), for: .disabled)
    }
    let continueBtn = UIButton(type: .system).then {
        $0.setTitle("계속하기", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundColor(.primary400, for: .normal)
        $0.setBackgroundColor(.gray300, for: .disabled)
    }
    private let againLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.text = "인증번호 다시받기"
        $0.textColor = .gray600
    }
    private let endTimer = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.text = "인증번호를 다시 받아주세요."
        $0.textColor = .red
        $0.isHidden = true
    }
    private let authenticationNumberProgressBar = UIProgressView().then {
        $0.progressViewStyle = .bar
        $0.progressTintColor = .primary400
        $0.trackTintColor = .gray400
        $0.progress = 0.16
    }
    private let infoLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }
    private let authenticationNumberLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
        $0.text = "전화번호 인증"
    }
    let authenticationNumberTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.gray400.cgColor
        $0.borderStyle = UITextField.BorderStyle.none
        $0.placeholder = "인증번호"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.addLeftPadding()
        $0.keyboardType = .numberPad
        $0.textContentType = .oneTimeCode
    }
    private let accessoryView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 72.0))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
        setTextField()
        setBtn()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkBtn.isEnabled = true
        self.isRunningTimer = true
        setTime()
        setNavigation()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        continueBtn.layer.masksToBounds = true
        addSubviews()
        makeSubviewConstraints()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setBtn() {
        checkBtn.rx.tap.subscribe(onNext: {
            self.checkBtn.isEnabled = false
            self.timerValue = 300
        }).disposed(by: disposeBag)
    }

    private func setTextField() {
        authenticationNumberTextField.rx.text.orEmpty
            .subscribe(onNext: {
                if $0.count == 5 {
                    self.infoLabel.isHidden = true
                    self.continueBtn.isEnabled = true
                } else {
                    self.infoLabel.isHidden = false
                    self.continueBtn.isEnabled = false
                }
            }).disposed(by: disposeBag)

        authenticationNumberTextField.inputAccessoryView = accessoryView

        authenticationNumberTextField.keyboardType = .asciiCapable
    }

    private func setNavigation() {
        navigationController?.navigationBar.setBackButtonToArrow()
        self.navigationItem.searchController = nil
    }

    private func setTime() {
        let driver = Driver<Int>.interval(.seconds(1))
            .map { _ in return 1 }

        driver.asObservable()
            .subscribe(onNext: { value in
                if self.isRunningTimer {
                    self.timerValue -= value
                    self.timerLabel.text = "\(self.timerValue / 60) : \(String(format: "%02d", self.timerValue % 60))"
                } else if self.timerValue == 0 {
                    self.timerLabel.textColor = .red
                    self.endTimer.isHidden = false
                    self.isRunningTimer = false
                }
            }).disposed(by: disposeBag)
    }

    private func bind() {
        let input = AuthenicationNumberViewModel.Input(
            name: name,
            phoneNumber: phoneNumber,
            authCode: authenticationNumberTextField.rx.text.orEmpty.asDriver(),
            continueButtonDidTap: continueBtn.rx.tap.asDriver(),
            checkButtonDidTap: checkBtn.rx.tap.asDriver()
        )

        _ = viewModel.transform(input)
    }
}

// MARK: Layout
extension AuthenticationNumberViewController {
    private func addSubviews() {
        accessoryView.addSubview(continueBtn)
        [authenticationNumberProgressBar, infoLabel, authenticationNumberLabel,
         authenticationNumberTextField, timerLabel, againLabel, checkBtn, endTimer]
            .forEach { view.addSubview($0) }
    }

    private func makeSubviewConstraints() {

        authenticationNumberLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(16)
        }
        authenticationNumberTextField.snp.makeConstraints {
            $0.top.equalTo(authenticationNumberLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
        continueBtn.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
            $0.bottom.equalToSuperview()
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(authenticationNumberTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
        }
        authenticationNumberProgressBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
            $0.trailing.leading.equalToSuperview()
        }
        timerLabel.snp.makeConstraints {
            $0.trailing.equalTo(authenticationNumberTextField.snp.trailing).inset(20)
            $0.centerY.equalTo(authenticationNumberTextField)
        }
        againLabel.snp.makeConstraints {
            $0.top.equalTo(authenticationNumberTextField.snp.bottom).offset(44)
            $0.leading.equalToSuperview().inset(136)
        }
        checkBtn.snp.makeConstraints {
            $0.top.equalTo(authenticationNumberTextField.snp.bottom).offset(46)
            $0.leading.equalTo(againLabel.snp.trailing).offset(4)
            $0.height.width.equalTo(16)
        }
        endTimer.snp.makeConstraints {
            $0.top.equalTo(authenticationNumberTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
        }
    }
}
