import UIKit

class FooterView: UIView {
    let commentLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(commentLabel)
        commentLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
