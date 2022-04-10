import UIKit

import Then

class PersonalInformationPolicyViewController: UIViewController {

    private let personalInformationPolicyLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray600
    }
    private let personalInformationPolicyTitleLabel = UILabel().then {
        $0.text = "개인정보 취급방침"
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
        $0.textColor = .gray900
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        view.backgroundColor = .white
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
    }

    private func setNavigation() {
        navigationController?.navigationBar.setBackButtonToArrow()
    }
}

// MARK: Layout
extension PersonalInformationPolicyViewController {

    private func addSubviews() {
        [personalInformationPolicyLabel, personalInformationPolicyTitleLabel]
            .forEach { view.addSubview($0) }
    }
    private func makeSubviewConstraints() {

        personalInformationPolicyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(148)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        personalInformationPolicyTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(16)
        }
    }

}
