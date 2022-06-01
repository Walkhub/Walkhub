import UIKit

import SnapKit
import Then

class NotificationListTableViewCell: UITableViewCell {

    let profileImg = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .white
    }
    let name = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray700
    }
    let title = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray900
    }
    let timeLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray700
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .white
        addSubviews()
        makeSubviewConstraints()
        profileImg.layer.cornerRadius = profileImg.frame.width / 2
        profileImg.clipsToBounds = true
    }

}

extension NotificationListTableViewCell {
    private func addSubviews() {
        [profileImg, name, title, timeLabel].forEach { self.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        profileImg.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.height.width.equalTo(24)
        }
        name.snp.makeConstraints {
            $0.centerY.equalTo(profileImg)
            $0.leading.equalTo(profileImg.snp.trailing).offset(16)
        }
        title.snp.makeConstraints {
            $0.top.equalTo(name.snp.bottom).offset(6)
            $0.leading.equalTo(name.snp.leading)
            $0.bottom.equalToSuperview().inset(12)
        }
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
