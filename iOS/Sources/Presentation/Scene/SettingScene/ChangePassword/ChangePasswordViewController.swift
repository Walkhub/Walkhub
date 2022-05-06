import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class ChangePasswordViewController: UIViewController {
    var viewModel: ChangePasswordViewModel!
    var currentPassword = String()

    private var disposeBag = DisposeBag()

    private let newPasswordLabel = UILabel().then {
        $0.text = "새 비밀번호"
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
    }
    private let newPasswordTxtField = UITextField().then {
        $0.placeholder = "비밀번호(8~30자, 특수문자 1개 이상)"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.colorBDBDBD.cgColor
        $0.layer.cornerRadius = 12
        $0.addLeftPadding()
    }
    private let infoLabel = UILabel().then {
        $0.text = """
        비밀번호는 8~30자 내로
        특수문자를 1개 이상 포함하여 입력해주세요.
        """
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .red
        $0.numberOfLines = 2
    }
    private let changeButton = UIButton(type: .system).then {
        $0.setBackgroundColor(.colorE0E0E0, for: .disabled)
        $0.setBackgroundColor(.primary400, for: .normal)
        $0.setTitle("변경하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "비밀번호 변경"
        navigationController?.navigationBar.setBackButtonToArrow()
        view.backgroundColor = .white
        setButton()
        bind()
    }
    override func viewDidLayoutSubviews() {
        addSubivews()
        makeSubviewConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.infoLabel.isHidden = true
    }

    private func setButton() {
        newPasswordTxtField.rx.text.orEmpty
            .map { self.isVaildTest(str: $0) }
            .bind(to: changeButton.rx.isEnabled)
            .disposed(by: disposeBag)

        newPasswordTxtField.rx.text.orEmpty
            .map { self.isVaildTest(str: $0) }
            .bind(to: infoLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
    private func isVaildTest(str: String?) -> Bool {
        guard str != nil else { return false }

        let strRegEx = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,30}"
        let pred = NSPredicate(format: "SELF MATCHES %@", strRegEx)

        return pred.evaluate(with: str)
    }
    private func bind() {
        let input = ChangePasswordViewModel.Input(
            currentPassword: currentPassword,
            newPasseord: newPasswordTxtField.rx.text.orEmpty.asDriver(),
            changeButtonDidTap: changeButton.rx.tap.asDriver()
        )
        _ = viewModel.transform(input)
    }
}

// MARK: Layout
extension ChangePasswordViewController {
    private func addSubivews() {
        [newPasswordLabel, newPasswordTxtField, infoLabel, changeButton].forEach { view.addSubview($0) }
    }
    private func makeSubviewConstraints() {
        newPasswordLabel.snp.makeConstraints {
            $0.topMargin.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        newPasswordTxtField.snp.makeConstraints {
            $0.top.equalTo(newPasswordLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(newPasswordTxtField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(36)
        }
        changeButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
    }
}
