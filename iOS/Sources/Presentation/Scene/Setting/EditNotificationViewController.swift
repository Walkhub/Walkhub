import UIKit

import SnapKit
import Then

class EditNotificationViewController: UIViewController {

    private let line1 = UIView().then {
        $0.backgroundColor = .gray200
    }

    private let recordMeasurementLabel = UILabel().then {
        $0.text = "기록측정 알림"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .color757575
    }

    private let getCheerLabel = UILabel().then {
        $0.text = "응원 받기"
        $0.textColor = .gray800
        $0.font = .notoSansFont(ofSize: 16, family: .regular)
    }

    private let getCheerSwitches = UISwitch().then {
        $0.isOn = true
        $0.onTintColor = .primary400
        $0.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }

    private let line2 = UIView().then {
        $0.backgroundColor = .gray200
    }

    private let hubLabel = UILabel().then {
        $0.text = "허브 알림"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .color757575
    }

    private let notificationLabel = UILabel().then {
        $0.text = "공지사항"
        $0.textColor = .gray800
        $0.font = .notoSansFont(ofSize: 16, family: .regular)
    }

    private let notificationSwitches = UISwitch().then {
        $0.isOn = true
        $0.onTintColor = .primary400
        $0.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }

    private let line3 = UIView().then {
        $0.backgroundColor = .gray200
    }

    private let challengeLabel = UILabel().then {
        $0.text = "챌린지 알림"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .color757575
    }

    private let recommendChallengeLabel = UILabel().then {
        $0.text = "챌린지 추천"
        $0.textColor = .gray800
        $0.font = .notoSansFont(ofSize: 16, family: .regular)
    }

    private let recommendChallengeSwitches = UISwitch().then {
        $0.isOn = true
        $0.onTintColor = .primary400
        $0.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }

    private let goalChallengeLabel = UILabel().then {
        $0.text = "챌린지 목표 달성"
        $0.textColor = .gray800
        $0.font = .notoSansFont(ofSize: 16, family: .regular)
    }

    private let goalChallengeSwitches = UISwitch().then {
        $0.isOn = true
        $0.onTintColor = .primary400
        $0.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }

    private let endChallengeLabel = UILabel().then {
        $0.text = "챌린지 종료"
        $0.textColor = .gray800
        $0.font = .notoSansFont(ofSize: 16, family: .regular)
    }

    private let endChallengeSwitches = UISwitch().then {
        $0.isOn = true
        $0.onTintColor = .primary400
        $0.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
    }
}

extension EditNotificationViewController {

    private func addSubviews() {
        [line1, recordMeasurementLabel, getCheerLabel, getCheerSwitches,
        line2, hubLabel, notificationLabel, notificationSwitches, line3,
        challengeLabel, recommendChallengeLabel, recommendChallengeSwitches,
        goalChallengeLabel, goalChallengeSwitches, endChallengeLabel,
         endChallengeSwitches].forEach { view.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        line1.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets.snp.top)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        recordMeasurementLabel.snp.makeConstraints {
            $0.top.equalTo(line1.snp.bottom).offset(11)
            $0.leading.equalToSuperview().inset(16)
        }

        getCheerLabel.snp.makeConstraints {
            $0.top.equalTo(recordMeasurementLabel.snp.bottom).offset(26)
            $0.leading.equalToSuperview().inset(16)
        }

        getCheerSwitches.snp.makeConstraints {
            $0.centerY.equalTo(getCheerLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        line2.snp.makeConstraints {
            $0.top.equalTo(getCheerLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        hubLabel.snp.makeConstraints {
            $0.top.equalTo(line2.snp.bottom).offset(11)
            $0.leading.equalToSuperview().inset(16)
        }

        notificationLabel.snp.makeConstraints {
            $0.top.equalTo(hubLabel.snp.bottom).offset(26)
            $0.leading.equalToSuperview().inset(16)
        }

        notificationSwitches.snp.makeConstraints {
            $0.centerY.equalTo(notificationLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        line3.snp.makeConstraints {
            $0.top.equalTo(notificationLabel.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        challengeLabel.snp.makeConstraints {
            $0.top.equalTo(line3.snp.bottom).offset(11)
            $0.leading.equalToSuperview().inset(16)
        }

        recommendChallengeLabel.snp.makeConstraints {
            $0.top.equalTo(challengeLabel.snp.bottom).offset(26)
            $0.leading.equalToSuperview().inset(16)
        }

        recommendChallengeSwitches.snp.makeConstraints {
            $0.centerY.equalTo(recommendChallengeLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        goalChallengeLabel.snp.makeConstraints {
            $0.top.equalTo(recommendChallengeLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(16)
        }

        goalChallengeSwitches.snp.makeConstraints {
            $0.centerY.equalTo(goalChallengeLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        endChallengeLabel.snp.makeConstraints {
            $0.top.equalTo(goalChallengeLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(16)
        }

        endChallengeSwitches.snp.makeConstraints {
            $0.centerY.equalTo(endChallengeLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
