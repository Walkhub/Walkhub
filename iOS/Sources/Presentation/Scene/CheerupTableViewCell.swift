import UIKit

import SnapKit
import Then

class CheerupTableViewCell: UITableViewCell {

    let imgView = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    let blueView = UIView().then {
        $0.backgroundColor = .primary400
    }

    let recordName = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .bold)
        $0.textColor = .white
    }

    let recordComment = UILabel().then {
        $0.text = "님의 기록을 응원합니다."
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
        $0.textColor = .white
    }

    let cheerUpBtn = UIButton(type: .system).then {
        $0.setImage(.init(named: "CheerUpImg"), for: .normal)
        $0.imageView?.contentMode = .scaleToFill
        $0.imageView?.backgroundColor = .white
        $0.layer.cornerRadius = $0.frame.height / 2
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        addSubviews()
        makeSubviewConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension CheerupTableViewCell {
    private func addSubviews() {
        self.addSubview(blueView)
        [imgView, recordName, recordComment, cheerUpBtn]
            .forEach { self.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        blueView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        imgView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.height.width.equalTo(40)
        }

        recordName.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(imgView.snp.trailing).offset(16)
        }

        recordComment.snp.makeConstraints {
            $0.bottom.equalTo(recordName)
            $0.leading.equalTo(recordName.snp.trailing)
        }

        cheerUpBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(32)
            $0.width.height.equalTo(28)
        }
    }
}
