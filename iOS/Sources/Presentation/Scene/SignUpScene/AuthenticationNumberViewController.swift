import UIKit

import SnapKit
import RxCocoa
import RxSwift

class AuthenticationNumberViewController: UIViewController {

    var disposeBag = DisposeBag()

    private let timerLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .primary400
    }

    private let checkBtn = UIButton().then {
        $0.setImage(UIImage.init(systemName: "square"), for: .normal)
        $0.tintColor = .gray600
        $0.setImage(UIImage.init(systemName: "checkmark.square"), for: .selected)
    }

    var limitTime: Int = 300

    private let continueBtn = UIButton(type: .system).then {
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

    @objc func getSetTime() {
        secToTime(sec: limitTime)
        limitTime -= 1
    }

    func secToTime(sec: Int) {
        let minute = (sec % 3600) / 60
        let second = (sec % 3600) % 60

        if second < 10 {
            timerLabel.text = String(minute) + ":" + "0"+String(second)
        } else {
            timerLabel.text = String(minute) + ":" + String(second)
        }

        if limitTime != 0 {
            perform(#selector(getSetTime), with: nil, afterDelay: 1.0)
        } else if limitTime == 0 {
            timerLabel.textColor = .red
            endTimer.isHidden = false
        }
    }

    enum AuthenticationNumberRange {
        case over
        case under
        case normal
        case middle
    }

    private func authenticationNumber(_ name: String) -> AuthenticationNumberRange {
        if name.count > 5 {
            let index = name.index(name.startIndex, offsetBy: 6)
            self.authenticationNumberTextField.text = String(name[..<index])

            return .over
        } else if name.count < 1 {
            return .under
        } else if name.count < 5 && name.count > 0 {
            return .middle
        } else {
            return .normal
        }
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

    private let backBtn = UIBarButtonItem().then {
        $0.image = .init(systemName: "arrow.backward")
        $0.tintColor = .gray500
    }

    private let authenticationNumberLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
        $0.text = "전화번호 인증"
    }

    private let authenticationNumberTextField = UITextField().then {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTextField()
        addSubviews()
        makeSubviewConstraints()
        setBtn()
        checkBtn.isSelected = false
        authenticationNumberTextField.inputAccessoryView = accessoryView
    }

    override func viewWillAppear(_ animated: Bool) {
        getSetTime()
    }

    private func setBtn() {
        checkBtn.rx.tap.subscribe(onNext: {
            self.checkBtn.isSelected = true
        }).disposed(by: disposeBag)

        continueBtn.rx.tap
            .bind {
                print("clicked")
            }
            .disposed(by: disposeBag)
    }

    private func setTextField() {
        authenticationNumberTextField.rx.text.orEmpty
            .map { $0 != "" }
            .bind(to: continueBtn.rx.isEnabled)
            .disposed(by: disposeBag)

        authenticationNumberTextField.rx.text.orEmpty
            .map(authenticationNumber(_:))
            .subscribe(onNext: { authenticationNumber in
                switch authenticationNumber {
                case .over:
                    self.infoLabel.textColor = .red
                    self.infoLabel.text = "인증번호 5자리를 입력해주세요."
                    self.continueBtn.isEnabled = false

                case .under:
                    self.infoLabel.textColor = .red
                    self.infoLabel.text = ""
                    self.continueBtn.isEnabled = false

                case .middle:
                    self.infoLabel.textColor = .red
                    self.infoLabel.text = "인증번호 5자리를 입력해주세요."
                    self.continueBtn.isEnabled = false

                case .normal:
                    self.infoLabel.textColor = .red
                    self.infoLabel.text = ""
                    self.continueBtn.isEnabled = true
                }
            })
            .disposed(by: disposeBag)
    }

    override func viewDidLayoutSubviews() {
        continueBtn.layer.masksToBounds = true
    }

    private let accessoryView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 72.0))

    private func setNavigation() {
        navigationItem.leftBarButtonItem = backBtn
        self.navigationItem.searchController = nil
        self.navigationItem.leftBarButtonItem = backBtn
    }
}

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
