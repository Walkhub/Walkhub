import UIKit

import SnapKit
import Then

class CustomAlert: UIView {

    private let backView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }

    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }

    let cancelBtn = UIButton(type: .system).then {
        $0.setBackgroundColor(.gray100, for: .normal)
        $0.setTitleColor(.color616161, for: .normal)
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }

    let okBtn = UIButton(type: .system).then {
        $0.setBackgroundColor(.primary400, for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }

    func setup(title: String, cancel: String, ok: String) {
        titleLabel.text = title
        cancelBtn.setTitle(cancel, for: .normal)
        okBtn.setTitle(ok, for: .normal)
    }

    override func layoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
    }
}

extension CustomAlert {

    private func addSubviews() {
        self.addSubview(backView)

        [titleLabel, cancelBtn, okBtn].forEach { backView.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
        }

        cancelBtn.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16)
            $0.width.equalTo(128)
            $0.height.equalTo(52)
        }

        okBtn.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(cancelBtn.snp.trailing).offset(8)
            $0.trailing.bottom.equalToSuperview().inset(16)
            $0.width.equalTo(128)
            $0.height.equalTo(52)
        }
    }
}
