import UIKit

class MyRankTableViewCell: UITableViewCell {

    private let view = UIView().then {
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .white
    }

    let profileImgView = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    let nameLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    let stepCountLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }

    let rankLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    let progressBar = UIProgressView().then {
        $0.progressViewStyle = .default
        $0.trackTintColor = .gray300
        $0.progressTintColor = .primary400
    }

    let nextLevelLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }

    let goalStepCountLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .gray50
        addSubviews()
        makeSubviewConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

// MARK: - Layout
extension MyRankTableViewCell {
    private func addSubviews() {
        self.addSubview(view)

        [profileImgView, nameLabel, stepCountLabel, rankLabel, progressBar,
         nextLevelLabel, goalStepCountLabel].forEach { view.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        view.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        profileImgView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(40)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(11)
            $0.leading.equalTo(profileImgView.snp.trailing).offset(16)
        }

        stepCountLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalTo(profileImgView.snp.trailing).offset(16)
        }

        rankLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(16)
        }

        progressBar.snp.makeConstraints {
            $0.top.equalTo(stepCountLabel.snp.bottom).offset(19)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(8)
        }

        nextLevelLabel.snp.makeConstraints {
            $0.top.equalTo(progressBar.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
        }

        goalStepCountLabel.snp.makeConstraints {
            $0.top.equalTo(nextLevelLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
