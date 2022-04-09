import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class IDViewController: UIViewController {

    var viewModel: IDViewModel!
    var disposeBag = DisposeBag()

    private let idProgressBar = UIProgressView().then {
        $0.progressViewStyle = .bar
        $0.progressTintColor = .primary400
        $0.trackTintColor = .gray400
        $0.progress = 0.32
    }
    private let infoLabel = UILabel().then {
        $0.text = "새로운 아이디를 입력해주세요."
        $0.textColor = .red
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
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
    private let accessoryView = UIView(frame: CGRect(
        x: 0.0,
        y: 0.0,
        width: UIScreen.main.bounds.width,
        height: 72.0
    ))
    let idTextField = UITextField().then {
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
        view.backgroundColor = .white
        setNavigation()
        setTextField()
        bind()
        idTextField.inputAccessoryView = accessoryView
    }

    override func viewWillAppear(_ animated: Bool) {
        continueBtn.isEnabled = false
        infoLabel.isHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSubviews()
        makeSubviewConstraints()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    private func setNavigation() {
        navigationController?.navigationBar.setBackButtonToArrow()
    }

    private func setTextField() {
        idTextField.rx.text.orEmpty
            .subscribe(onNext: {
                self.infoLabel.isHidden = $0.count > 4 && $0.count < 31
                self.continueBtn.isEnabled = $0.count > 4 && $0.count < 31
            }).disposed(by: disposeBag)
    }

    private func bind() {
        let input = IDViewModel.Input(
            id: idTextField.rx.text.orEmpty.asDriver(),
            continueButtonDidTap: continueBtn.rx.tap.asDriver()
        )
        _ = viewModel.transform(input)
    }
}

// MARK: Layout
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
