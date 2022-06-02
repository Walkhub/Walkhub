import UIKit

import SnapKit
import Then

class SchoolNoticeTableViewCell: UITableViewCell {

    let titleLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray900
    }
    let dateLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray600
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func layoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
    }
}

// MARK: - Layout
extension SchoolNoticeTableViewCell {
    private func addSubviews() {
        [titleLabel, dateLabel].forEach { self.addSubview($0) }
    }
    private func makeSubviewConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(9)
            $0.leading.equalToSuperview().inset(16)
        }
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(9)
        }
    }
}
