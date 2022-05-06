import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Service

class CheckPasswordViewController: UIViewController {

    var viewModel: CheckPasswordViewModel!
    private var disposeBag = DisposeBag()

    private let currentPassword = UILabel().then {
        $0.text = "현재 비밀번호"
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
    }
    private let currentPasswordTxtField = UITextField().then {
        $0.placeholder = "현재 비밀번호를 입력해주세요."
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.colorBDBDBD.cgColor
        $0.layer.cornerRadius = 12
        $0.addLeftPadding()
    }
    private let continueButton = UIButton(type: .system).then {
        $0.setTitle("계속하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundColor(.colorE0E0E0, for: .disabled)
        $0.setBackgroundColor(.primary400, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        bind()
        view.backgroundColor = .white
        self.title = "비밀번호 변경"
        navigationController?.navigationBar.setBackButtonToArrow()
    }
    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
    }

    private func setButton() {
        currentPasswordTxtField.rx.text.orEmpty
            .map { $0 != "" }
            .bind(to: continueButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    private func bind() {
        let input = CheckPasswordViewModel.Input(
            password: currentPasswordTxtField.rx.text.orEmpty.asDriver(),
            contineButtonDidTap: continueButton.rx.tap.asDriver())

        _ = viewModel.transform(input)
    }
}

// MARK: Layout
extension CheckPasswordViewController {
    private func addSubviews() {
        [currentPassword, currentPasswordTxtField, continueButton].forEach { view.addSubview($0) }
    }
    private func makeSubviewConstraints() {
        currentPassword.snp.makeConstraints {
            $0.topMargin.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        currentPasswordTxtField.snp.makeConstraints {
            $0.top.equalTo(currentPassword.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
        continueButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
    }
}
