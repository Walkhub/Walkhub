import UIKit

class SecondMainpageTableViewCell: UITableViewCell {

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
        $0.layer.cornerRadius = 15
        $0.image = .init(systemName: "clock.fill")
        $0.tintColor = .init(named: "F9F9F9")!
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
        setUp()
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
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(24)
        }

        recordLabel.snp.makeConstraints {
            $0.top.equalTo(fastLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(24)
        }

        rankImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
            $0.height.width.equalTo(48)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
}
