import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class LoginViewController: UIViewController {

    var viewModel: LoginViewModel!

    // MARK: UI
    private let idTextField = WHTextfield().then {
        $0.placeholder = "아이디"
        $0.autocapitalizationType = .none
        $0.keyboardType = .asciiCapable
    }
    private let passwordTextField = WHTextfield().then {
        $0.placeholder = "비밀번호"
        $0.isSecureTextEntry = true
        $0.keyboardType = .asciiCapable
    }
    private let loginButton = UIButton(type: .system).then {
        $0.setTitle("로그인하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.backgroundColor = .primary400
        $0.layer.cornerRadius = 12
    }
    private let findIdButton = UIButton(type: .system).then {
        $0.setTitle("아이디 찾기", for: .normal)
        $0.setTitleColor(.gray400, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.titleLabel?.textAlignment = .right
    }
    private let lineViewBetweenFindIdAndChangePwdBtn = UIView().then {
        $0.backgroundColor = .gray200
    }
    private let changePasswordButton = UIButton(type: .system).then {
        $0.setTitle("비밀번호 변경", for: .normal)
        $0.setTitleColor(.gray400, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.titleLabel?.textAlignment = .left
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupNavigaionBar()
        bind()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewContraints()
    }

}

// MARK: - Bind ViewModel
extension LoginViewController {
    private func bind() {
        let input = LoginViewModel.Input(
            idTextfieldString: self.idTextField.rx.text.orEmpty.asDriver(),
            passwordTextfieldString: self.passwordTextField.rx.text.orEmpty.asDriver(),
            loginButtonIsTapped: loginButton.rx.tap.asDriver(),
            findIdButtonIsTapped: findIdButton.rx.tap.asDriver(),
            changePasswordButtonIsTapped: changePasswordButton.rx.tap.asDriver()
        )
        _ = viewModel.transform(input)
    }
}

// MARK: - NavigaionBar
extension LoginViewController {
    private func setupNavigaionBar() {
        self.navigationController?.navigationBar.setBackButtonToX()
    }
}

// MARK: - Layout
extension LoginViewController {

    private func addSubviews() {
        [idTextField,
         passwordTextField,
         loginButton,
         findIdButton,
         lineViewBetweenFindIdAndChangePwdBtn,
         changePasswordButton
        ].forEach {
            self.view.addSubview($0)
        }
    }

    private func makeSubviewContraints() {

        idTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            $0.left.right.equalToSuperview().inset(16)
        }
        passwordTextField.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.top.equalTo(idTextField.snp.bottom).offset(8)
            $0.left.right.equalToSuperview().inset(16)
        }
        loginButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(16)
        }
        lineViewBetweenFindIdAndChangePwdBtn.snp.makeConstraints {
            $0.height.equalTo(16)
            $0.width.equalTo(1)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(loginButton.snp.bottom).offset(22)
        }
        findIdButton.snp.makeConstraints {
            $0.centerY.equalTo(lineViewBetweenFindIdAndChangePwdBtn)
            $0.right.equalTo(lineViewBetweenFindIdAndChangePwdBtn.snp.left).offset(-12)
        }
        changePasswordButton.snp.makeConstraints {
            $0.centerY.equalTo(lineViewBetweenFindIdAndChangePwdBtn)
            $0.left.equalTo(lineViewBetweenFindIdAndChangePwdBtn.snp.right).offset(12)
        }
    }

}
