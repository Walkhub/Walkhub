import UIKit

import SnapKit
import Then

class SchoolRankTableViewCell: UITableViewCell {

    let imgView = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    let schoolName = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    let gradeClassLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }

    let badgeImgView = UIImageView()

    let rankLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        addSubviews()
        makeSubviewContraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func addSubviews() {
        [imgView, schoolName, gradeClassLabel, badgeImgView, rankLabel]
            .forEach { self.addSubview($0) }
    }

    private func makeSubviewContraints() {
        imgView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.height.width.equalTo(40)
        }

        schoolName.snp.makeConstraints {
            $0.top.equalToSuperview().inset(11)
            $0.width.equalTo(176)
            $0.leading.equalTo(imgView.snp.trailing).offset(16)
        }

        gradeClassLabel.snp.makeConstraints {
            $0.top.equalTo(schoolName.snp.bottom)
            $0.leading.equalTo(imgView.snp.trailing).offset(16)
            $0.bottom.equalToSuperview().inset(11)
        }

        badgeImgView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(rankLabel.snp.leading).offset(-11)
            $0.height.equalTo(26)
            $0.width.equalTo(14)
        }

        rankLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
