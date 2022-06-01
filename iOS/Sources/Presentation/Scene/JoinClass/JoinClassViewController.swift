import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class JoinClassViewController: UIViewController {

    var viewModel: JoinClassViewModel!
    var classCode = String()

    private var disposeBag = DisposeBag()
    // MARK: - UI
    private let titleLabel = UILabel().then {
        $0.text = "번호 등록"
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
        $0.textColor = .gray900
    }
    private let contentLabel = UILabel().then {
        $0.text = "반에서 사용하는 번호를 입력해주세요."
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray600
    }
    private let accessoryView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 52))
    private let classNumberTextField = UITextField().then {
        $0.keyboardType = .numberPad
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray400.cgColor
        $0.textColor = .gray900
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.addLeftPadding()
    }
    private let joinClassButton = UIButton(type: .system).then {
        $0.setTitle("반 가입 완료하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .primary400
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
    }
    private let errorLabel = UILabel().then {
        $0.text = "올바른 번호를 입력해주세요."
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .red
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setObject()
        view.backgroundColor = .white
        classNumberTextField.inputAccessoryView = accessoryView
        self.navigationController?.navigationBar.setBackButtonToArrow()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addSubviews()
        makeSubviewConstraints()
        classNumberTextField.clipsToBounds = true
    }
    override func viewWillAppear(_ animated: Bool) {
        joinClassButton.isEnabled = false
        errorLabel.isHidden = true
    }

    // MARK: - Bind
    private func bind() {
        let input = JoinClassViewModel.Input(
            joinClassButtonDidTap: joinClassButton.rx.tap.asDriver(),
            classCode: classCode,
            classNumber: classNumberTextField.rx.text.orEmpty.asDriver()
        )
        _ = viewModel.transform(input)
    }

    // MARK: - Set Object
    private func setObject() {
        classNumberTextField.rx.text.orEmpty
            .map { $0.count > 0 && $0.count < 3 }
            .bind(to: joinClassButton.rx.isEnabled)
            .disposed(by: disposeBag)

        classNumberTextField.rx.text.orEmpty
            .map { $0.count > 0 && $0.count < 3 }
            .bind(to: errorLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
}

// MARK: - Layout
extension JoinClassViewController {
    private func addSubviews() {
        accessoryView.addSubview(joinClassButton)
        [titleLabel, contentLabel, classNumberTextField, errorLabel]
            .forEach { view.addSubview($0) }
    }
    private func makeSubviewConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(114)
            $0.leading.equalToSuperview().inset(16)
        }
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
        }
        classNumberTextField.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(classNumberTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
        }
        joinClassButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
