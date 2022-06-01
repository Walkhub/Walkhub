import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import DPOTPView
import RxFlow

class EnterClassCodeViewController: UIViewController{

    var viewModel: EnterClassCodeViewModel!

    private var disposeBag = DisposeBag()
    private var code = PublishRelay<String>()

    // MARK: - UI
    private let titleLabel = UILabel().then {
        $0.text = "반 친구들과 함께 걷고 \n내 랭킹 확인하기"
        $0.textAlignment = .left
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
        $0.textColor = .gray900
    }
    private let contentLabel = UILabel().then {
        $0.text = "반 가입코드를 입력해주세요."
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray600
    }
    private let dpotpView = DPOTPView().then {
        $0.count = 7
        $0.spacing = 8
        $0.fontTextField = .notoSansFont(ofSize: 24, family: .medium)
        $0.textColorTextField = .gray800
        $0.backGroundColorTextField = .gray50
        $0.cornerRadiusTextField = 12
    }
    private let enterButton = UIButton(type: .system).then {
        $0.setTitle("입력완료", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.setTitleColor(.white, for: .normal)
        $0.setBackgroundColor(.primary400, for: .normal)
        $0.setBackgroundColor(.gray300, for: .disabled)
        $0.layer.cornerRadius = 12
    }
    private let errorLabel = UILabel().then {
        $0.text = "반을 찾을 수 없어요. 가입코드를 다시 확인해주세요."
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .red
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setButton()
        dpotpView.dpOTPViewDelegate = self
        self.navigationController?.navigationBar.setBackButtonToArrow()
        view.backgroundColor = .white
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addSubviews()
        makeSubviewConstraints()
        enterButton.clipsToBounds = true
    }
    override func viewWillAppear(_ animated: Bool) {
        enterButton.isEnabled = false
        errorLabel.isHidden = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // MARK: - SetButton
    private func setButton() {
        code.map { $0.count == 7 }
            .bind(to: enterButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    // MARK: - Bind
    private func bind() {
        let input = EnterClassCodeViewModel.Input(
            joinButtonDidTap: enterButton.rx.tap.asDriver(),
            classCode: code.asDriver(onErrorJustReturn: "")
        )
        let output = viewModel.transform(input)

        output.error.asObservable()
            .subscribe(onNext: {
                self.errorLabel.isHidden = $0
            }).disposed(by: disposeBag)
    }
}

// MARK: - Layout
extension EnterClassCodeViewController {
    private func addSubviews() {
        [titleLabel, contentLabel, dpotpView, enterButton, errorLabel]
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
        dpotpView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(dpotpView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
        }
        enterButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
    }
}

extension EnterClassCodeViewController: DPOTPViewDelegate {
    func dpOTPViewAddText(_ text: String, at position: Int) {
        code.accept(text)
    }
    func dpOTPViewRemoveText(_ text: String, at position: Int) {
        code.accept(text)
    }

    func dpOTPViewChangePositionAt(_ position: Int) {
    }

    func dpOTPViewBecomeFirstResponder() {
    }

    func dpOTPViewResignFirstResponder() {
    }
}
