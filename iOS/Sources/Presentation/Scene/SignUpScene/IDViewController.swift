import UIKit

import Then
import RxSwift
import SnapKit

class IDViewController: UIViewController {

    var disposeBag = DisposeBag()

    enum IDRange {
        case over
        case under
        case normal
        case middle
    }

    private func checkId(_ name: String) -> IDRange {
        if name.count > 30 {
            let index = name.index(name.startIndex, offsetBy: 31)
            self.idTextField.text = String(name[..<index])

            return .over
        } else if name.count < 5 && name.count > 0 {
            return .under
        } else if name.count < 2 {
            return .middle
        } else {
            return .normal
        }
    }

    private let idProgressBar = UIProgressView().then {
        $0.progressViewStyle = .bar
        $0.progressTintColor = .primary400
        $0.trackTintColor = .gray400
        $0.progress = 0.32
    }

    private let infoLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let backBtn = UIBarButtonItem().then {
        $0.image = .init(systemName: "arrow.backward")
        $0.tintColor = .gray500
    }

    private let idLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
        $0.text = "아이디"
    }

    private let continueBtn = UIButton(type: .system).then {
        $0.setTitle("계속하기", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundColor(.primary400, for: .normal)
        $0.setBackgroundColor(.gray300, for: .disabled)
    }

    private let accessoryView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 72.0))

    private let idTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.gray400.cgColor
        $0.borderStyle = UITextField.BorderStyle.none
        $0.placeholder = "아이디(5~30자)"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.addLeftPadding()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeSubviewConstraints()
        setNavigation()
        setTextField()
        idTextField.inputAccessoryView = accessoryView
    }

    private func setNavigation() {
        navigationItem.leftBarButtonItem = backBtn
    }

    private func setTextField() {
        idTextField.rx.text.orEmpty
            .map(checkId(_:))
            .subscribe(onNext: { identity in
                switch identity {
                case .over:
                    self.infoLabel.textColor = .red
                    self.infoLabel.text = "아이디는 5~30자 내로 입력해주세요."
                    self.continueBtn.isEnabled = false

                case .under:
                    self.infoLabel.textColor = .red
                    self.infoLabel.text = "아이디는 5~30자 내로 입력해주세요."
                    self.continueBtn.isEnabled = false

                case .normal:
                    self.infoLabel.textColor = .red
                    self.infoLabel.text = ""
                    self.continueBtn.isEnabled = true

                case .middle:
                    self.continueBtn.isEnabled = false
                }
            })
            .disposed(by: disposeBag)
    }
}

extension IDViewController {
    private func addSubviews() {
        accessoryView.addSubview(continueBtn)
        [idLabel, idTextField, infoLabel, idProgressBar]
            .forEach { view.addSubview($0) }
    }
    private func makeSubviewConstraints() {

        idLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(16)
        }

        idTextField.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(20)
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
            $0.top.equalTo(idTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
        }

        idProgressBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
            $0.trailing.leading.equalToSuperview()
        }
    }
}
