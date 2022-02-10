import UIKit

import SnapKit
import Then

class HealthInfoTableViewCell: UITableViewCell {

    let whCircleProgressView = WHCircleProgressView().then {
        $0.setup(
            totalAngle: 300,
            progressThickness: 0.2,
            trackThickness: 0.2,
            trackColor: .init(named: "F9F9F9")!,
            progressColor: .link
        )
        $0.progress = 80
    }

    let clockLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    let locationLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    let fireLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    let fire = UIImageView().then {
        $0.image = .init(systemName: "flame.fill")
        $0.tintColor = .black
    }

    let location = UIImageView().then {
        $0.image = .init(systemName: "location.square")
        $0.tintColor = .black
    }

    let clock = UIImageView().then {
        $0.image = .init(systemName: "clock.fill")
        $0.tintColor = .black
    }

    let label = UILabel().then {
        $0.font = .notoSansFont(ofSize: 24, family: .medium)
    }

    let stepLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    let imgView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = $0.frame.width / 2
        $0.image = .init(systemName: "clock.fill")
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        makeSubviewConstraints()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        demoData()
    }

    private func demoData() {
        clockLabel.text = "7"
        locationLabel.text = "0.52"
        fireLabel.text = "158"
        label.text = "5329"
        stepLabel.text = "/6000 걸음"
    }
}

extension MainPageTableViewCell {

private func addSubviews() {
        [whCircleProgressView, imgView, label, stepLabel,
         clock, location, fire, clockLabel, locationLabel, fireLabel]
            .forEach { self.addSubview($0)}
    }

    private func makeSubviewConstraints() {
        whCircleProgressView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(71)
            $0.top.equalToSuperview().inset(40)
            $0.height.equalTo(187)
        }

        imgView.snp.makeConstraints {
            $0.top.equalTo(whCircleProgressView.snp.top).offset(10)
            $0.leading.equalTo(whCircleProgressView.snp.leading).inset(30)
            $0.trailing.equalTo(whCircleProgressView.snp.trailing).inset(30)
            $0.bottom.equalTo(whCircleProgressView.snp.bottom).inset(10)
        }

        label.snp.makeConstraints {
            $0.top.equalToSuperview().inset(210)
            $0.centerX.equalTo(imgView)
        }

        stepLabel.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom)
            $0.centerX.equalTo(imgView)
        }

        clock.snp.makeConstraints {
            $0.top.equalTo(whCircleProgressView.snp.bottom).offset(78)
            $0.leading.equalToSuperview().inset(57)
        }

        location.snp.makeConstraints {
            $0.top.equalTo(whCircleProgressView.snp.bottom).offset(78)
            $0.centerX.equalTo(label)
        }

        fire.snp.makeConstraints {
            $0.top.equalTo(whCircleProgressView.snp.bottom).offset(78)
            $0.trailing.equalToSuperview().inset(57)
        }

        clockLabel.snp.makeConstraints {
            $0.top.equalTo(clock.snp.bottom).offset(4)
            $0.centerX.equalTo(clock)
        }

        locationLabel.snp.makeConstraints {
            $0.top.equalTo(location.snp.bottom).offset(4)
            $0.centerX.equalTo(location)
        }

        fireLabel.snp.makeConstraints {
            $0.top.equalTo(fire.snp.bottom).offset(4)
            $0.centerX.equalTo(fire)
            $0.bottom.equalToSuperview().inset(30)
        }
    }
}
