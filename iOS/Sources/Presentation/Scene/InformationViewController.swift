import UIKit

import SnapKit
import Then

class InformationViewController: UIViewController {

    private let informationLabel = UILabel().then {
        $0.text = "학교 정보"
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let whiteView = UIView().then {
        $0.backgroundColor = .white
    }

    private let line = UIView().then {
        $0.backgroundColor = .gray200
    }

    private let totalStepCountLabel = UILabel().then {
        $0.text = "지난주 걸음수 총합"
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let totalStepCountNumLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let stepCountLabel = UILabel().then {
        $0.text = "걸음"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let timeLabel = UILabel().then {
        $0.text = "시간"
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let hourLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let hLabel = UILabel().then {
        $0.text = "h"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let minuteLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let mLabel = UILabel().then {
        $0.text = "m"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let stepByStepLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray800
    }

    private let rankLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
        $0.textColor = .gray800
    }

    private let joinerLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray800
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray50
        demoData()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
    }

    private func demoData() {
        totalStepCountNumLabel.text = "932,320"
        hourLabel.text = "1"
        minuteLabel.text = "30"
        stepByStepLabel.text = "총 932,320 걸음"
        rankLabel.text = "4등"
        joinerLabel.text = "참가자 240명"
    }
}

// MARK: - Layout
extension InformationViewController {
    private func addSubviews() {
        [whiteView, stepByStepLabel, rankLabel, joinerLabel].forEach { view.addSubview($0) }

        [informationLabel, line, totalStepCountLabel, totalStepCountNumLabel, stepCountLabel,
         timeLabel, hourLabel, hLabel, minuteLabel, mLabel].forEach { whiteView.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        whiteView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        informationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(120)
            $0.leading.equalToSuperview().inset(16)
        }

        line.snp.makeConstraints {
            $0.top.equalTo(informationLabel.snp.bottom).offset(98)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(1)
        }

        totalStepCountLabel.snp.makeConstraints {
            $0.top.equalTo(informationLabel.snp.bottom).offset(82)
            $0.trailing.equalTo(line.snp.leading).offset(-27)
        }

        totalStepCountNumLabel.snp.makeConstraints {
            $0.top.equalTo(totalStepCountLabel.snp.bottom).offset(4)
            $0.leading.equalTo(totalStepCountLabel.snp.leading).offset(7)
        }

        stepCountLabel.snp.makeConstraints {
            $0.bottom.equalTo(totalStepCountNumLabel.snp.bottom)
            $0.leading.equalTo(totalStepCountNumLabel.snp.trailing).offset(2)
        }

        timeLabel.snp.makeConstraints {
            $0.top.equalTo(totalStepCountLabel.snp.top)
            $0.leading.equalTo(line.snp.trailing).offset(69)
        }

        hourLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
            $0.leading.equalTo(line.snp.trailing).offset(51)
            $0.bottom.equalToSuperview().inset(40)
        }

        hLabel.snp.makeConstraints {
            $0.bottom.equalTo(hourLabel.snp.bottom)
            $0.leading.equalTo(hourLabel.snp.trailing).offset(2)
        }

        minuteLabel.snp.makeConstraints {
            $0.bottom.equalTo(hourLabel.snp.bottom)
            $0.leading.equalTo(hLabel.snp.trailing).offset(4)
        }

        mLabel.snp.makeConstraints {
            $0.bottom.equalTo(hourLabel.snp.bottom)
            $0.leading.equalTo(minuteLabel.snp.trailing).offset(2)
        }

        stepByStepLabel.snp.makeConstraints {
            $0.top.equalTo(whiteView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(40)
        }

        rankLabel.snp.makeConstraints {
            $0.top.equalTo(stepByStepLabel.snp.bottom).offset(19)
            $0.leading.equalToSuperview().inset(61)
        }

        joinerLabel.snp.makeConstraints {
            $0.top.equalTo(rankLabel.snp.bottom).offset(14)
            $0.centerX.equalToSuperview()
        }
    }
}
