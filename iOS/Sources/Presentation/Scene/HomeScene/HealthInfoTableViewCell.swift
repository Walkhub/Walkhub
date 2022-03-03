import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Service
import Kingfisher

class HealthInfoTableViewCell: UITableViewCell {

    private var disposeBag = DisposeBag()

    let whCircleProgressView = WHCircleProgressView().then {
        $0.setup(
            totalAngle: 300,
            progressThickness: 0.2,
            trackThickness: 0.2,
            trackColor: .gray200,
            progressColor: .primary400
        )
    }

    let burnKcalLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    let distanceLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    let timeLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    let fire = UIImageView().then {
        $0.image = .init(named: "fireImg")
    }

    let distance = UIImageView().then {
        $0.image = .init(named: "distanceImg")
    }

    let clock = UIImageView().then {
        $0.image = .init(named: "ClockImg")
    }

    let label = UILabel().then {
        $0.font = .notoSansFont(ofSize: 24, family: .medium)
    }

    let stepLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    let imgView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .systemBackground
        self.selectionStyle = .none
        addSubviews()
        makeSubviewConstraints()
    }

    func setup(
        dailyExercisesData: PublishRelay<DailyExerciseRecord>,
        caloriesData: PublishRelay<CaloriesLevel>,
        exerciseAnalysis: PublishRelay<ExerciseAnalysis>
    ) {
        dailyExercisesData.asObservable().observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { data in
                self.distanceLabel.text = String(format: "%.1f", data.walkingRunningDistanceAsMeter / 1000.0)
                self.timeLabel.text = "\(Int(data.walkingRunningTimeAsSecond) / 60)"
                self.burnKcalLabel.text = "\(Int(data.burnedKilocalories))"
                self.label.text = "\(data.stepCount)"
        }).disposed(by: disposeBag)

        exerciseAnalysis.asObservable().observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { data in
                if data.dailyWalkCountGoal == 0 {
                    self.whCircleProgressView.progress = (Double(data.walkCount) / 10000) * 100.0
                } else {
                    self.whCircleProgressView.progress = (Double(data.walkCount) / Double(data.dailyWalkCountGoal)) * 100.0
                }
                self.stepLabel.text = "/\(data.dailyWalkCountGoal) 걸음"
        }).disposed(by: disposeBag)

        caloriesData.asObservable().observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { data in
                self.imgView.kf.setImage(with: data.foodImageUrl)
        }).disposed(by: disposeBag)
    }
}

extension HealthInfoTableViewCell {

    private func addSubviews() {
        [whCircleProgressView, label, stepLabel,
         fire, distance, clock, burnKcalLabel, distanceLabel, timeLabel]
            .forEach { self.contentView.addSubview($0)}
        whCircleProgressView.addSubview(imgView)
    }

    private func makeSubviewConstraints() {
        whCircleProgressView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.left.right.equalToSuperview().inset(64)
            $0.height.equalTo(whCircleProgressView.snp.width)
        }

        imgView.snp.makeConstraints {
            $0.left.top.right.bottom.equalToSuperview().inset(20)
        }

        label.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom)
            $0.centerX.equalToSuperview()
        }

        stepLabel.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom)
            $0.centerX.equalToSuperview()
        }

        fire.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(57)
            $0.width.height.equalTo(16)
        }

        distance.snp.makeConstraints {
            $0.top.equalTo(fire.snp.top)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(16)
        }

        clock.snp.makeConstraints {
            $0.top.equalTo(fire.snp.top)
            $0.trailing.equalToSuperview().inset(57)
            $0.width.height.equalTo(16)
        }

        burnKcalLabel.snp.makeConstraints {
            $0.top.equalTo(fire.snp.bottom).offset(4)
            $0.centerX.equalTo(fire)
        }

        distanceLabel.snp.makeConstraints {
            $0.top.equalTo(distance.snp.bottom).offset(4)
            $0.centerX.equalTo(distance)
        }

        timeLabel.snp.makeConstraints {
            $0.top.equalTo(clock.snp.bottom).offset(4)
            $0.centerX.equalTo(clock)
        }
    }
}
