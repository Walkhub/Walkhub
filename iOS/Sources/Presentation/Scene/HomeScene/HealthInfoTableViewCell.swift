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
    }

    internal func setup(
        dailyExercisesData: PublishRelay<DailyExerciseRecord>,
        caloriesData: PublishRelay<CaloriesLevel>,
        exerciseAnalysis: PublishRelay<ExerciseAnalysis>
    ) {
        dailyExercisesData.asObservable().subscribe(onNext: {
            self.clockLabel.text = "\($0.walkingRunningTimeAsSecond * 60)"
            self.fireLabel.text = "\($0.burnedKilocalories)"
            self.locationLabel.text = "\($0.walkingRunningDistanceAsMeter)"
            self.label.text = "\($0.stepCount)"
        }).disposed(by: disposeBag)

        exerciseAnalysis.asObservable().subscribe(onNext: {
            self.whCircleProgressView.progress = Double($0.walkCount / $0.dailyWalkCountGoal)
            self.stepLabel.text = "/\($0.dailyWalkCountGoal) 걸음"
        }).disposed(by: disposeBag)

        caloriesData.asObservable().subscribe(onNext: {
            self.imgView.image = $0.foodImageUrlString.toImage()
        }).disposed(by: disposeBag)
    }
}

extension HealthInfoTableViewCell {

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
