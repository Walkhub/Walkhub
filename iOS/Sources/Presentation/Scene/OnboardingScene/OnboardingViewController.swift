import UIKit

import RxCocoa
import RxFlow
import RxSwift
import SnapKit
import Then

class OnboardingViewController: UIViewController, Stepper {

    private let disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    private let backgroundImageView = UIImageView().then {
        $0.isUserInteractionEnabled = true
        $0.contentMode = .scaleAspectFill
        $0.image = .onboardingBackgroundImage
    }
    private let nameLabel = UILabel().then {
        $0.text = "Walkhub"
        $0.font = .notoSansFont(ofSize: 24, family: .medium)
        $0.textAlignment = .right
        $0.textColor = .primary400
    }
    private let copywritingLabel = UILabel().then {
        $0.text = """
        끝이없다.
        나의 걸음은,
        """
        $0.font = .notoSansFont(ofSize: 32, family: .bold)
        $0.textAlignment = .right
        $0.textColor = .white
        $0.numberOfLines = 0
    }
    private let signupButton = UIButton(type: .system).then {
        $0.setTitle("가입하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.backgroundColor = .primary400
        $0.layer.cornerRadius = 12
    }
    private let signinButton = UIButton(type: .system).then {
        $0.setDoubleColorTitle(string1: "이미 계정이 있나요? ", color1: .white, string2: " 로그인하기", color2: .primary400)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setButtonsAction()

    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewContraints()
    }

    private func setButtonsAction() {

        signupButton.rx.tap
            .map { WalkhubStep.signupIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

        signinButton.rx.tap
            .map { WalkhubStep.loginIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)

    }

}

// MARK: - Layout
extension OnboardingViewController {

    private func addSubviews() {
        self.view.addSubview(backgroundImageView)
        [signupButton, signinButton, nameLabel, copywritingLabel].forEach {
            self.backgroundImageView.addSubview($0)
        }
    }

    private func makeSubviewContraints() {
        backgroundImageView.snp.makeConstraints {
            $0.left.top.right.bottom.equalToSuperview()
        }
        signinButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaInsets).inset(32)
        }
        signupButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.left.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(signinButton.snp.top).offset(-20)
        }
        copywritingLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(signupButton.snp.top).offset(-32)
        }
        nameLabel.snp.makeConstraints {
            $0.right.equalToSuperview().inset(16)
            $0.bottom.equalTo(copywritingLabel.snp.top).offset(-8)
        }
    }

}
