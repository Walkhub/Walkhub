import UIKit

class WholeChallengeTableViewCell: UITableViewCell {

    private let challengeView = UIView().then {
        $0.backgroundColor = .white
    }

    private let challengeTitleLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
        $0.textColor = .gray900
    }

    private let organizerLable = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .medium)
        $0.textColor = .gray800
    }

    private let dateLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray700
    }

    private let schoolLogoImageView = UIImageView().then {
        $0.image = .init(systemName: "circle.fill")
        $0.tintColor = .gray800
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    private let pointImageView = UIImageView().then {
        $0.image = .init(systemName: "circle.fill")
        $0.tintColor = .gray800
    }

    private let dotImageView = UIImageView().then {
        $0.image = .init(systemName: "circle.fill")
        $0.tintColor = .gray800
    }

    private let targetDistanceLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .medium)
        $0.textColor = .gray800
    }

    private let purposeLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }

    private let profileImageView = UIImageView().then {
        $0.image = .init(systemName: "circle.fill")
        $0.tintColor = .gray800
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    private let secondProfileImageView = UIImageView().then {
        $0.image = .init(systemName: "circle.fill")
        $0.tintColor = .gray600
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    private let thirdProfileImageView = UIImageView().then {
        $0.image = .init(systemName: "circle.fill")
        $0.tintColor = .gray400
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    private let participantsLabel = UILabel().then {
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
        demoData()
    }

    func demoData() {
        challengeTitleLabel.text = "2학년 체육 수행평가"
        organizerLable.text = "서무성"
        dateLabel.text = "2022/03/02 ~ 2022/03/31"
        targetDistanceLabel.text = "기간 내 20km 달성"
        purposeLabel.text = "체육 수행평가 성적"
        participantsLabel.text = "최민준,김수완,수준호 외 21명 참여 중입니다."
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
