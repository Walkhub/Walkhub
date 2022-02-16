import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Then

class LoginViewController: UIViewController {

    var viewModel: LoginViewModel!

    private let logoImageView = UIImageView()
    private let nameLabel = UILabel().then {
        $0.text = "Walkhub"
        $0.font = .notoSansFont(ofSize: 24, family: .medium)
        $0.textColor = .primary400
    }
    private let copywritingLabel = UILabel().then {
        $0.text = "요즘걷들의 최신 트랜드"
        $0.font = .notoSansFont(ofSize: 16, family: .regular)
    }
    private let idTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton().then {
        $0.setTitle("가입하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.backgroundColor = .primary400
        $0.layer.cornerRadius = 12
    }
    private let findIdButton = UIButton().then {
        $0.setTitle("아이디 찾기", for: .normal)
        $0.setTitleColor(.gray400, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.titleLabel?.textAlignment = .right
    }
    private let changePasswordButton = UIButton().then {
        $0.setTitle("비밀번호 변경", for: .normal)
        $0.setTitleColor(.gray400, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.titleLabel?.textAlignment = .left
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        setupNavigaionBar()
    }

}

// MARK: - NavigaionBar
extension LoginViewController {
    private func setupNavigaionBar() {
        self.navigationController?.navigationBar.setupBackButton()
    }
}
