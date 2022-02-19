import UIKit

import SnapKit
import Then

class SchoolListTableViewCell: UITableViewCell {

    private let logoImgView = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.size.height / 2
        $0.contentMode = .scaleToFill
    }

    private let schoolNameLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        makeSubviewConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SchoolListTableViewCell {
    private func addSubviews() {
        [logoImgView, schoolNameLabel].forEach { self.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        logoImgView.snp.makeConstraints {
            $0.bottom.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(32)
            $0.height.width.equalTo(40)
        }

        schoolNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(logoImgView.snp.trailing).offset(16)
        }
    }
}
