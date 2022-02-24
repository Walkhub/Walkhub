import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Service

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
        $0.backgroundColor = .gray200
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
        dailyExercisesData.asObservable().subscribe(onNext: { data in
            DispatchQueue.main.async {
                self.clockLabel.text = "\(Int(data.walkingRunningTimeAsSecond / 60))"
                self.fireLabel.text = "\(-(Int(data.burnedKilocalories)))"
                self.locationLabel.text = String(format: "%0.2f", data.walkingRunningDistanceAsMeter / 1000 )
                self.label.text = "\(data.stepCount)"
            }
        }).disposed(by: disposeBag)

        exerciseAnalysis.asObservable().subscribe(onNext: { data in
            DispatchQueue.main.async {
                self.whCircleProgressView.progress = Double(data.walkCount / data.dailyWalkCountGoal)
                self.stepLabel.text = "/\(data.dailyWalkCountGoal) 걸음"
            }
        }).disposed(by: disposeBag)

        caloriesData.asObservable().subscribe(onNext: {
            self.imgView.image = $0.foodImageUrlString.toImage()
        }).disposed(by: disposeBag)
    }
}

extension HealthInfoTableViewCell {

    private func addSubviews() {
        [whCircleProgressView, label, stepLabel,
         clock, location, fire, clockLabel, locationLabel, fireLabel]
            .forEach { self.contentView.addSubview($0)}
        whCircleProgressView.addSubview(imgView)
    }

    private func makeSubviewConstraints() {
        whCircleProgressView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(40)
            $0.left.right.equalToSuperview().inset(64)
            $0.height.equalTo(whCircleProgressView.snp.width)
        }

        imgView.snp.makeConstraints {
            $0.left.top.right.bottom.equalToSuperview().inset(20)
            imgView.layer.cornerRadius = imgView.frame.width / 2
        }

        label.snp.makeConstraints {
            $0.top.equalTo(whCircleProgressView.snp.bottom)
            $0.centerX.equalToSuperview()
        }

        stepLabel.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom)
            $0.centerX.equalToSuperview()
        }

        clock.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(57)
            $0.width.height.equalTo(16)
        }

        location.snp.makeConstraints {
            $0.top.equalTo(clock.snp.top)
            $0.centerX.equalTo(label)
            $0.width.height.equalTo(16)
        }

        fire.snp.makeConstraints {
            $0.top.equalTo(clock.snp.top)
            $0.trailing.equalToSuperview().inset(57)
            $0.width.height.equalTo(16)
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
            $0.bottom.equalToSuperview().offset(-30)
        }
    }
}
