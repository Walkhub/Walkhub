import UIKit

import SnapKit
import Then

class MyPageViewController: UIViewController {

    private let profileView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }

    private let profileImgView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = $0.frame.height / 2
    }

    private let profileName = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let stepCountImgView = UIImageView().then {
        $0.image = .init(named: "StepCountImg")
        $0.contentMode = .scaleAspectFit
    }

    private let stepCounLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let clockImgView = UIImageView().then {
        $0.image = .init(named: "ClockImg")
        $0.contentMode = .scaleAspectFit
    }
    
    private let timeLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let locationImgView = UIImageView().then {
        $0.image = .init(named: "DistanceImg")
        $0.contentMode = .scaleAspectFit
    }

    private let distanceLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let fireImgView = UIImageView().then {
        $0.image = .init(named: "FireImg")
        $0.contentMode = .scaleAspectFit
    }

    private let kcalLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let schoolView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }

    private let schoolImgView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = $0.frame.height / 2
    }

    private let schoolName = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let classLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }

    private let badgeView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }

    private let badgeImgView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = $0.frame.height / 2
    }

    private let badgeLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let badgeCommentLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray500
    }

    private let levelView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }

    private let levelImgView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = $0.frame.height / 2
    }

    private let levelLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let levelCommentLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray500
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray50
        demoData()
        setNavigation()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
    }

    private func demoData() {
        profileImgView.image = .init(systemName: "clock.fill")
        profileName.text = "김기영"
        schoolImgView.image = .init(systemName: "clock.fill")
        schoolName.text = "대덕소프트웨어마이스터고등학교"
        classLabel.text = "3학년 4반"
        badgeImgView.image = .init(systemName: "clock.fill")
        badgeLabel.text = "전교 1등"
        badgeCommentLabel.text = "최고 배지"
        levelImgView.image = .init(systemName: "clock.fill")
        levelLabel.text = "카페 라떼"
        levelCommentLabel.text = "최고 등급"
        stepCounLabel.text = "10000"
        timeLabel.text = "3"
        distanceLabel.text = "0.43"
        kcalLabel.text = "3210"
    }

    private func setNavigation() {
        let titleLabel = UILabel().then {
            $0.textColor = .black
            $0.text = "마이페이지"
            $0.font = .notoSansFont(ofSize: 20, family: .medium)
            $0.textAlignment = .left
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        self.navigationItem.titleView = titleLabel
        guard let containerView = self.navigationItem.titleView?.superview else { return }

        let leftBarItemWidth = self.navigationItem.leftBarButtonItems?.reduce(0, { $0 + $1.width })
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor,
                                             constant: (leftBarItemWidth ?? 0) + 16),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor)
        ])
    }
}

extension MyPageViewController {
    private func addSubviews() {
        [profileView, schoolView, badgeView, levelView].forEach { view.addSubview($0) }

        [profileImgView, profileName, stepCountImgView, stepCounLabel,
        clockImgView, timeLabel, locationImgView, distanceLabel,
        fireImgView, kcalLabel].forEach { profileView.addSubview($0) }

        [schoolImgView, schoolName, classLabel].forEach { schoolView.addSubview($0) }

        [badgeImgView, badgeLabel, badgeCommentLabel].forEach { badgeView.addSubview($0) }

        [levelImgView, levelLabel, levelCommentLabel].forEach { levelView.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        profileView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(150)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(184)
        }

        profileImgView.snp.makeConstraints {
            $0.centerY.equalTo(profileView.snp.top)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(80)
        }

        profileName.snp.makeConstraints {
            $0.top.equalTo(profileImgView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }

        stepCountImgView.snp.makeConstraints {
            $0.top.equalTo(profileName.snp.bottom).offset(30)
            $0.width.height.equalTo(16)
            $0.leading.equalToSuperview().inset(47)
        }

        stepCounLabel.snp.makeConstraints {
            $0.centerX.equalTo(stepCountImgView)
            $0.top.equalTo(stepCountImgView.snp.bottom).offset(4)
        }

        clockImgView.snp.makeConstraints {
            $0.top.equalTo(stepCountImgView.snp.top)
            $0.width.height.equalTo(16)
            $0.leading.equalTo(stepCountImgView.snp.trailing).offset(57)
        }

        timeLabel.snp.makeConstraints {
            $0.centerX.equalTo(clockImgView)
            $0.top.equalTo(clockImgView.snp.bottom).offset(4)
        }

        locationImgView.snp.makeConstraints {
            $0.top.equalTo(stepCountImgView.snp.top)
            $0.trailing.equalTo(fireImgView.snp.leading).offset(-57)
            $0.width.height.equalTo(16)
        }

        distanceLabel.snp.makeConstraints {
            $0.top.equalTo(locationImgView.snp.bottom).offset(4)
            $0.centerX.equalTo(locationImgView)
        }

        fireImgView.snp.makeConstraints {
            $0.top.equalTo(locationImgView.snp.top)
            $0.trailing.equalToSuperview().inset(47)
        }

        kcalLabel.snp.makeConstraints {
            $0.top.equalTo(fireImgView.snp.bottom).offset(4)
            $0.centerX.equalTo(fireImgView)
        }

        schoolView.snp.makeConstraints {
            $0.top.equalTo(profileView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(64)
        }

        schoolImgView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.height.width.equalTo(40)
        }

        schoolName.snp.makeConstraints {
            $0.top.equalTo(schoolImgView.snp.top)
            $0.leading.equalTo(schoolImgView.snp.trailing).offset(16)
        }

        classLabel.snp.makeConstraints {
            $0.top.equalTo(schoolName.snp.bottom)
            $0.leading.equalTo(schoolName.snp.leading)
        }

        badgeView.snp.makeConstraints {
            $0.top.equalTo(schoolView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(134)
            $0.width.equalTo(160)
        }

        badgeImgView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(64)
        }

        badgeLabel.snp.makeConstraints {
            $0.top.equalTo(badgeImgView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }

        badgeCommentLabel.snp.makeConstraints {
            $0.top.equalTo(badgeLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }

        levelView.snp.makeConstraints {
            $0.top.equalTo(badgeView.snp.top)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(134)
            $0.width.equalTo(160)
        }

        levelImgView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(64)
        }

        levelLabel.snp.makeConstraints {
            $0.top.equalTo(levelImgView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }

        levelCommentLabel.snp.makeConstraints {
            $0.top.equalTo(levelLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
    }
}
