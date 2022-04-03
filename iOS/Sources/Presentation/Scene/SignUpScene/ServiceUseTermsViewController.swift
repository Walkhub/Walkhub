import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import RxFlow

class ServiceUseTermsViewController: UIViewController, Stepper {

    var steps = PublishRelay<Step>()

    private let serviceUseTermsLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray600
    }

    private let serviceUseTermsTitleLabel = UILabel().then {
        $0.text = "서비스 이용약관"
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
        $0.textColor = .gray900
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
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
extension ServiceUseTermsViewController {

    private func addSubviews() {
        [serviceUseTermsLabel, serviceUseTermsTitleLabel]
            .forEach { view.addSubview($0) }
    }

    private func makeSubviewConstraints() {

        serviceUseTermsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(148)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        serviceUseTermsTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(16)
        }
    }
}
