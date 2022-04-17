import UIKit

class WholeChallengeTableViewCell: UITableViewCell {

    let challengeView = UIView().then {
        $0.backgroundColor = .white
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

    let pointImageView = UIImageView().then {
        $0.tintColor = .gray800
    }

    let dotImageView = UIImageView().then {
        $0.tintColor = .gray800
    }

    let targetDistanceLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .medium)
        $0.textColor = .gray800
    }

    let purposeLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }

    let profileImageView = UIImageView().then {
        $0.tintColor = .gray800
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    let secondProfileImageView = UIImageView().then {
        $0.tintColor = .gray600
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    let thirdProfileImageView = UIImageView().then {
        $0.tintColor = .gray400
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    let participantsLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray700
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubviews()
        makeSubviewConstraints()
    }
}

extension WholeChallengeTableViewCell {

    private func addSubviews() {
    [challengeView,
     challengeTitleLabel,
     organizerLable,
     dateLabel,
     schoolLogoImageView,
     pointImageView,
     dotImageView,
     targetDistanceLabel,
     purposeLabel,
     thirdProfileImageView,
     secondProfileImageView,
     profileImageView,
     participantsLabel
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

        schoolLogoImageView.snp.makeConstraints {
            $0.height.width.equalTo(40)
            $0.top.equalTo(challengeView.snp.top).offset(18)
            $0.leading.equalTo(challengeView.snp.leading).inset(16)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(challengeTitleLabel.snp.bottom).offset(1)
            $0.leading.equalTo(organizerLable.snp.trailing).offset(8)
        }

        targetDistanceLabel.snp.makeConstraints {
            $0.top.equalTo(schoolLogoImageView.snp.bottom).offset(12)
            $0.leading.equalTo(pointImageView.snp.trailing).offset(8)
        }

        purposeLabel.snp.makeConstraints {
            $0.top.equalTo(schoolLogoImageView.snp.bottom).offset(12)
            $0.leading.equalTo(dotImageView.snp.trailing).offset(8)
        }

        pointImageView.snp.makeConstraints {
            $0.top.equalTo(schoolLogoImageView.snp.bottom).offset(20)
            $0.leading.equalTo(challengeView.snp.leading).offset(16)
            $0.height.width.equalTo(4)
        }

        dotImageView.snp.makeConstraints {
            $0.top.equalTo(schoolLogoImageView.snp.bottom).offset(20)
            $0.leading.equalTo(targetDistanceLabel.snp.trailing).offset(8)
            $0.height.width.equalTo(4)
        }

        profileImageView.snp.makeConstraints {
            $0.top.equalTo(targetDistanceLabel.snp.bottom).offset(8)
            $0.leading.equalTo(challengeView.snp.leading).offset(16)
            $0.height.width.equalTo(20)
        }

        secondProfileImageView.snp.makeConstraints {
            $0.top.equalTo(targetDistanceLabel.snp.bottom).offset(8)
            $0.leading.equalTo(challengeView.snp.leading).offset(28)
            $0.height.width.equalTo(20)
        }

        thirdProfileImageView.snp.makeConstraints {
            $0.top.equalTo(targetDistanceLabel.snp.bottom).offset(8)
            $0.leading.equalTo(challengeView.snp.leading).offset(40)
            $0.height.width.equalTo(20)
        }

        participantsLabel.snp.makeConstraints {
            $0.top.equalTo(targetDistanceLabel.snp.bottom).offset(9)
            $0.leading.equalTo(thirdProfileImageView.snp.trailing).offset(8)
        }
    }
}
