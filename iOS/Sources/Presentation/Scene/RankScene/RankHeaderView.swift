import UIKit

class RankHeaderView: UIView {
    let schoolLabel = UILabel().then {
        $0.text = "학교"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    let switches = UISwitch().then {
        $0.isOn = false
        $0.onTintColor = .primary400
        $0.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    }

    let classLabel = UILabel().then {
        $0.text = "반"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    let dropDownBtn = DropDownButton().then {
        $0.setTitle(" 오늘\t", for: .normal)
        $0.arr = ["오늘", "이번주", "이번달"]
    }

    let myView = UIView().then {
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .white
    }

    let imgView = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.height / 2
        $0.contentMode = .scaleToFill
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

    let badgeImgView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeSubviewConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Layout
// swiftlint:disable function_body_length
extension RankHeaderView {
    private func addSubviews() {
        [schoolLabel, switches, classLabel, dropDownBtn, myView]
            .forEach { self.addSubview($0) }
        [imgView, nameLabel, stepCountLabel, rankLabel, badgeImgView, progressBar,
         nextLevelLabel, goalStepCountLabel].forEach { myView.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        schoolLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(16)
        }

        switches.snp.makeConstraints {
            $0.centerY.equalTo(schoolLabel)
            $0.leading.equalTo(schoolLabel.snp.trailing).offset(9)
        }

        classLabel.snp.makeConstraints {
            $0.top.equalTo(schoolLabel)
            $0.leading.equalTo(switches.snp.trailing).offset(9)
        }

        dropDownBtn.snp.makeConstraints {
            $0.centerY.equalTo(schoolLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        myView.snp.makeConstraints {
            $0.top.equalTo(schoolLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(12)
        }

        imgView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(40)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imgView)
            $0.leading.equalTo(imgView.snp.trailing).offset(16)
        }

        stepCountLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalTo(nameLabel)
        }

        rankLabel.snp.makeConstraints {
            $0.centerY.equalTo(imgView)
            $0.trailing.equalToSuperview().inset(16)
        }

        badgeImgView.snp.makeConstraints {
            $0.centerY.equalTo(imgView)
            $0.height.equalTo(27)
            $0.width.equalTo(14)
            $0.trailing.equalTo(rankLabel.snp.leading).inset(11)
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
            $0.bottom.equalTo(nextLevelLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
