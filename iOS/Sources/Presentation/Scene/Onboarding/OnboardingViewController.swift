import UIKit

import RxCocoa
import RxFlow
import RxSwift
import SnapKit
import Then

class OnboardingViewController: UIViewController, Stepper {

    private let disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()

    private let signupButton = UIButton(type: .system).then {
        $0.setTitle("가입하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.backgroundColor = .primary400
        $0.layer.cornerRadius = 12
    }
    private let signinButton = UIButton(type: .system).then {
        $0.setTitle("!!!", for: .normal)
        $0.setDoubleColorTitle(string1: "이미 계정이 있나요? ", color1: .gray400, string2: " 로그인하기", color2: .primary400)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewContraints()
    }

}

// MARK: - Layout
extension OnboardingViewController {

    private func addSubviews() {
        [signupButton, signinButton].forEach {
            self.view.addSubview($0)
        }
    }

    private func makeSubviewContraints() {
        signinButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.additionalSafeAreaInsets).inset(32)
        }
        signupButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.left.right.equalTo(self.additionalSafeAreaInsets).inset(16)
            $0.bottom.equalTo(self.signinButton.snp.top).offset(-20)
        }
    }

}
