import UIKit

class ParticipatingChallengeTableViewCell: UITableViewCell {

    let challengeView = UIView().then {
        $0.backgroundColor = .white
    }

    var challengeProgressView = UIProgressView().then {
        $0.progressViewStyle = .default
        $0.progressTintColor = .primary400
        $0.trackTintColor = .gray50
    }

    let challengeTitleLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
        $0.textColor = .gray900
    }

    let organizerLable = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .medium)
        $0.textColor = .gray800
    }

    let dateLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray700
    }

    let schoolLogoImageView = UIImageView().then {
        $0.tintColor = .gray800
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    let presentStepCountLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }

    let stepCountLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubviews()
        makeSubviewConstraints()
        // Configure the view for the selected state
    }

}

extension ParticipatingChallengeTableViewCell {

    private func addSubviews() {
    [challengeView,
     challengeProgressView,
     challengeTitleLabel,
     organizerLable,
     dateLabel,
     schoolLogoImageView,
     presentStepCountLabel,
     stepCountLabel
    ].forEach { self.addSubview($0) }
    }

    private func makeSubviewConstraints() {

        challengeView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(130)
            $0.leading.trailing.equalToSuperview().inset(11)
            $0.bottom.equalToSuperview().inset(11)
        }

        challengeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(challengeView.snp.top).offset(11)
            $0.leading.equalTo(schoolLogoImageView.snp.trailing).offset(16)
        }

        organizerLable.snp.makeConstraints {
            $0.top.equalTo(challengeTitleLabel.snp.bottom).offset(1)
            $0.leading.equalTo(schoolLogoImageView.snp.trailing).offset(16)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(challengeTitleLabel.snp.bottom).offset(1)
            $0.leading.equalTo(organizerLable.snp.trailing).offset(8)
        }

        challengeProgressView.snp.makeConstraints {
            $0.top.equalTo(organizerLable.snp.bottom).offset(19)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(8)
        }

        schoolLogoImageView.snp.makeConstraints {
            $0.height.width.equalTo(40)
            $0.top.equalTo(challengeView.snp.top).offset(18)
            $0.leading.equalTo(challengeView.snp.leading).inset(16)
        }

        presentStepCountLabel.snp.makeConstraints {
            $0.top.equalTo(challengeProgressView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(challengeView.snp.bottom).inset(12)
        }

        stepCountLabel.snp.makeConstraints {
            $0.top.equalTo(challengeProgressView.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(challengeView.snp.bottom).inset(12)
        }
    }
}
