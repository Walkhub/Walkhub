import UIKit

class StartExerciseMeasuringTableViewCell: UITableViewCell {

    let fastLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
        $0.text = "누구보다 빠르게"
    }

    let recordLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .bold)
        $0.text = "지금 바로 기록하기"
    }

    let rankImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 24
        $0.image = .init(systemName: "clear")
        $0.backgroundColor = .gray300
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.setSelected(false, animated: true)
        }
    }

    private func setUp() {
        self.contentView.addSubview(fastLabel)
        self.contentView.addSubview(recordLabel)
        self.contentView.addSubview(rankImageView)

        fastLabel.snp.makeConstraints {
            $0.bottom.equalTo(contentView.snp.centerY)
            $0.leading.equalToSuperview().inset(24)
        }

        recordLabel.snp.makeConstraints {
            $0.bottom.equalTo(contentView.snp.centerY)
            $0.leading.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(24)
        }

        rankImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
            $0.height.width.equalTo(48)
        }
    }
}
