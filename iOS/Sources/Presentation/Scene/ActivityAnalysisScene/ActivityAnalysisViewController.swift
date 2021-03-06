// swiftlint:disable file_length

import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Kingfisher

class ActivityAnalysisViewController: UIViewController {

    var viewModel: ActivityAnalysisViewModel!
    private var disposeBag = DisposeBag()
    private var goalCount = Int()
    private var calorie = Int()

    private let getData = PublishRelay<Void>()

    private let scrollView = UIScrollView()

    private let contentView = UIView()

    private let blueView = UIView().then {
        $0.backgroundColor = .primary400
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }

    private let imgView = UIImageView().then {
        $0.layer.shadowOffset = CGSize(width: -3, height: 3)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.3
        $0.backgroundColor = .white
    }

    private let foodName = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
        $0.textColor = .white
    }

    private let foodKcalLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
        $0.textColor = .white
    }

    private let kcalLabel = UILabel().then {
        $0.text = "kcal"
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
        $0.textColor = .white
    }

    private let criteriaLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
    }

    private let commentLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
    }

    private let levelLabel = UILabel().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.textColor = .primary400
        $0.textAlignment = .center
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.layer.cornerRadius = 10
    }

    private let levelProgressBarBackView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 7
        $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }

    private let levelProgressBar = UIProgressView().then {
        $0.progressViewStyle = .default
        $0.progressTintColor = .primary400
        $0.trackTintColor = .white
        $0.progress = 0.7
    }

    private let whiteView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 37
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private let dateLabel = UILabel().then {
        $0.textColor = .gray500
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let stepCountLabel = UILabel().then {
        $0.text = "?????????"
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let currentStepCountsLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let goalStepCountLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray800
    }

    private let stepCountProgressBackView = UIView().then {
        $0.backgroundColor = .gray100
        $0.layer.cornerRadius = 7
    }

    private let stepCountProgressBar = UIProgressView().then {
        $0.progressViewStyle = .default
        $0.progressTintColor = .primary400
        $0.trackTintColor = .gray100
        $0.progress = 0.7
    }

    private let burnKcalLaebel = UILabel().then {
        $0.text = "????????? ??????"
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let kcalCommentLabel = UILabel().then {
        $0.text = "??????????????? ???????????? ???????????????"
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
    }

    private let burnKcalNumLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let kcalLabel2 = UILabel().then {
        $0.text = "kcal"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let distanceLabel = UILabel().then {
        $0.text = "??????"
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let distanceNumLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let kmLabel = UILabel().then {
        $0.text = "km"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let timeLabel = UILabel().then {
        $0.text = "??????"
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

    private let line = UIView().then {
        $0.backgroundColor = .gray100
    }

    private let weekBtn = UIButton().then {
        $0.setTitle("??????", for: .normal)
        $0.isSelected = true
        $0.setBackgroundColor(.primary400, for: .selected)
        $0.setTitleColor(.white, for: .selected)
        $0.setTitleColor(.gray400, for: .normal)
        $0.setBackgroundColor(.white, for: .normal)
        $0.layer.cornerRadius = 14
        $0.clipsToBounds = true
    }

    private let monthBtn = UIButton().then {
        $0.setTitle("??????", for: .normal)
        $0.setBackgroundColor(.primary400, for: .selected)
        $0.setBackgroundColor(.white, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.setTitleColor(.gray400, for: .normal)
        $0.layer.cornerRadius = 14
        $0.clipsToBounds = true
    }

    private let charts = ChartView()

    private let allStepCountLabel = UILabel().then {
        $0.text = "?????? ??? ??????"
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let allStepCountNumLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let averageStepLabel = UILabel().then {
        $0.text = "?????? ?????? ???"
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let averageStepNumLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "????????????"
        view.backgroundColor = .gray50
        bindViewModel()
        setBtn()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
        blueView.roundCorners(cornerRadius: 64, byRoundingCorners: .topRight)
        imgView.layer.cornerRadius = imgView.frame.width/2
        imgView.layer.shadowPath = UIBezierPath(
            roundedRect: imgView.bounds,
            cornerRadius: imgView.frame.width / 2).cgPath
    }

    override func viewWillAppear(_ animated: Bool) {
        getData.accept(())
        self.tabBarController?.tabBar.isHidden = true
    }

    private func bindViewModel() {
        let input = ActivityAnalysisViewModel.Input(
            getData: getData.asDriver(onErrorJustReturn: ()),
            getWeekCharts: weekBtn.rx.tap.asDriver(),
            getMonthCharts: monthBtn.rx.tap.asDriver())

        let output = viewModel.transform(input)

        output.myCalorie.asObservable().observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { data in
                self.imgView.kf.setImage(with: data.foodImageUrl, options: [
                    .processor(RoundCornerImageProcessor(cornerRadius: self.imgView.frame.width/2))
                ])
                self.foodName.text = data.foodName
                self.foodKcalLabel.text = "\(data.calorie)"
                self.criteriaLabel.text = "\(data.size)"
                self.commentLabel.text = data.message
                self.levelLabel.text = "Lv.\(data.level)"
                self.calorie = data.calorie
        }).disposed(by: disposeBag)

        output.exerciseAnalysisData.asObservable().observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { data in
                self.goalStepCountLabel.text = "/\(data.dailyWalkCountGoal) ??????"
                self.goalCount = data.dailyWalkCountGoal
        }).disposed(by: disposeBag)

        output.dailyExerciseData.asObservable().observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { data in
                let minute = data.walkingRunningTimeAsSecond / 60
                self.currentStepCountsLabel.text = "\(data.stepCount)"
                self.distanceNumLabel.text = String(format: "%.1f", data.walkingRunningDistanceAsMeter / 1000)
                self.burnKcalNumLabel.text = "\(Int(data.burnedKilocalories))"
                self.hourLabel.text = "\(Int(minute) / 60)"
                self.minuteLabel.text = "\(Int(minute) % 60)"
                self.levelProgressBar.progress = Float(Double(data.burnedKilocalories) / Double(self.calorie))
                if self.goalCount == 0 {
                    self.stepCountProgressBar.progress = (Float(data.stepCount) / 10000.0)
                } else {
                    self.stepCountProgressBar.progress = (Float(data.stepCount) / Float(self.goalCount))
                }
        }).disposed(by: disposeBag)

        output.weekCharts.asObservable()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: {
            self.charts.setWeekCharts(stepCounts: $0.0)
            self.allStepCountNumLabel.text = "\($0.1)"
            self.averageStepNumLabel.text = "\($0.2)"
        }).disposed(by: disposeBag)

        output.monthCharts.asObservable()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: {
            self.charts.setMothCharts(stepCounts: $0.0)
            self.allStepCountNumLabel.text = "\($0.1)"
            self.averageStepNumLabel.text = "\($0.2)"
        }).disposed(by: disposeBag)
    }
}

extension ActivityAnalysisViewController {

    private func setBtn() {
        weekBtn.rx.tap.subscribe(onNext: {
            self.weekBtn.isSelected = true
            self.monthBtn.isSelected = false
        }).disposed(by: disposeBag)
        monthBtn.rx.tap.subscribe(onNext: {
            self.weekBtn.isSelected = false
            self.monthBtn.isSelected = true
        }).disposed(by: disposeBag)}
}

// MARK: - Layout
// swiftlint:disable function_body_length
extension ActivityAnalysisViewController {
    private func addSubviews() {
        view.addSubview(scrollView)

        scrollView.addSubview(contentView)

        [whiteView, blueView].forEach { contentView.addSubview($0) }

        [imgView, foodName, foodKcalLabel, kcalLabel, criteriaLabel,
         commentLabel, levelProgressBarBackView, levelProgressBar, levelLabel]
            .forEach { blueView.addSubview($0) }

        [dateLabel, stepCountLabel, currentStepCountsLabel, goalStepCountLabel,
         stepCountProgressBackView, stepCountProgressBar, burnKcalLaebel,
         kcalCommentLabel, burnKcalNumLabel, kcalLabel2, line,
         distanceLabel, distanceNumLabel, kmLabel, timeLabel, hourLabel, hLabel, minuteLabel, mLabel,
         weekBtn, monthBtn, charts, allStepCountLabel, allStepCountNumLabel, averageStepLabel, averageStepNumLabel]
            .forEach { whiteView.addSubview($0) }
    }

    private func makeSubviewConstraints() {

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(self.view)
        }

        blueView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(43)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(272)
        }

        imgView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(14)
            $0.width.height.equalTo(112)
        }

        foodName.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom).offset(9)
            $0.leading.equalToSuperview().inset(17)
        }

        foodKcalLabel.snp.makeConstraints {
            $0.top.equalTo(foodName.snp.bottom)
            $0.leading.equalToSuperview().inset(17)
        }

        kcalLabel.snp.makeConstraints {
            $0.bottom.equalTo(foodKcalLabel.snp.bottom)
            $0.leading.equalTo(foodKcalLabel.snp.trailing)
            $0.height.equalTo(foodKcalLabel.snp.height)
        }

        criteriaLabel.snp.makeConstraints {
            $0.top.equalTo(imgView.snp.bottom).offset(43)
            $0.leading.equalTo(kcalLabel.snp.trailing).offset(5)
        }

        commentLabel.snp.makeConstraints {
            $0.top.equalTo(foodKcalLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(17)
        }

        levelLabel.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(18)
            $0.height.equalTo(21)
            $0.width.equalTo(41)
        }

        levelProgressBarBackView.snp.makeConstraints {
            $0.centerY.equalTo(levelLabel)
            $0.leading.equalTo(levelLabel.snp.trailing).inset(4)
            $0.trailing.equalToSuperview().inset(17)
            $0.height.equalTo(11)
        }

        levelProgressBar.snp.makeConstraints {
            $0.centerY.equalTo(levelLabel)
            $0.trailing.equalTo(levelProgressBarBackView).inset(3)
            $0.leading.equalTo(levelProgressBarBackView.snp.leading)
            $0.height.equalTo(5)
        }

        whiteView.snp.makeConstraints {
            $0.top.equalTo(blueView.snp.bottom).inset(72)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(694)
            $0.bottom.equalToSuperview()
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(123)
            $0.leading.equalToSuperview().inset(39)
        }

        stepCountLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(39)
        }

        currentStepCountsLabel.snp.makeConstraints {
            $0.top.equalTo(stepCountLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(39)
        }

        goalStepCountLabel.snp.makeConstraints {
            $0.bottom.equalTo(currentStepCountsLabel.snp.bottom)
            $0.leading.equalTo(currentStepCountsLabel.snp.trailing).offset(4)
        }

        stepCountProgressBackView.snp.makeConstraints {
            $0.top.equalTo(goalStepCountLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(39)
            $0.height.equalTo(11)
        }

        stepCountProgressBar.snp.makeConstraints {
            $0.centerY.equalTo(stepCountProgressBackView)
            $0.leading.trailing.equalTo(stepCountProgressBackView).inset(3)
            $0.height.equalTo(5)
        }

        burnKcalLaebel.snp.makeConstraints {
            $0.top.equalTo(stepCountProgressBackView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(39)
        }

        kcalCommentLabel.snp.makeConstraints {
            $0.top.equalTo(burnKcalLaebel.snp.bottom)
            $0.leading.equalToSuperview().inset(39)
        }

        burnKcalNumLabel.snp.makeConstraints {
            $0.top.equalTo(kcalCommentLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(39)
        }

        kcalLabel2.snp.makeConstraints {
            $0.bottom.equalTo(burnKcalNumLabel.snp.bottom)
            $0.leading.equalTo(burnKcalNumLabel.snp.trailing).offset(4)
        }

        line.snp.makeConstraints {
            $0.top.equalTo(kcalLabel2.snp.bottom).offset(40)
            $0.width.equalTo(1)
            $0.height.equalTo(28)
            $0.centerX.equalToSuperview()
        }

        distanceLabel.snp.makeConstraints {
            $0.top.equalTo(kcalLabel2.snp.bottom).offset(24)
            $0.trailing.greaterThanOrEqualTo(line.snp.leading).offset(-69)
        }

        distanceNumLabel.snp.makeConstraints {
            $0.top.equalTo(distanceLabel.snp.bottom).offset(4)
            $0.trailing.equalTo(kmLabel.snp.leading).offset(-4)
        }

        kmLabel.snp.makeConstraints {
            $0.bottom.equalTo(distanceNumLabel.snp.bottom)
            $0.trailing.greaterThanOrEqualTo(line.snp.leading).offset(-53)
        }

        timeLabel.snp.makeConstraints {
            $0.top.equalTo(distanceLabel.snp.top)
            $0.leading.lessThanOrEqualTo(line.snp.trailing).offset(68)
        }

        hourLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
            $0.leading.lessThanOrEqualTo(line.snp.trailing).offset(51)
        }

        hLabel.snp.makeConstraints {
            $0.bottom.equalTo(hourLabel.snp.bottom)
            $0.leading.equalTo(hourLabel.snp.trailing).offset(2)
        }

        minuteLabel.snp.makeConstraints {
            $0.top.equalTo(hourLabel.snp.top)
            $0.leading.equalTo(hLabel.snp.trailing).offset(4)
        }

        mLabel.snp.makeConstraints {
            $0.bottom.equalTo(minuteLabel.snp.bottom)
            $0.leading.equalTo(minuteLabel.snp.trailing).offset(2)
        }

        weekBtn.snp.makeConstraints {
            $0.top.equalTo(distanceNumLabel.snp.bottom).offset(27)
            $0.trailing.equalTo(line.snp.leading).offset(-27)
            $0.width.equalTo(81)
            $0.height.equalTo(28)
        }

        monthBtn.snp.makeConstraints {
            $0.top.equalTo(weekBtn.snp.top)
            $0.leading.equalTo(line.snp.trailing).offset(27)
            $0.width.equalTo(81)
            $0.height.equalTo(28)
        }

        charts.snp.makeConstraints {
            $0.top.equalTo(monthBtn.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(42)
            $0.height.equalTo(136)
        }

        allStepCountLabel.snp.makeConstraints {
            $0.top.equalTo(charts.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(41)
        }

        allStepCountNumLabel.snp.makeConstraints {
            $0.centerY.equalTo(allStepCountLabel)
            $0.trailing.equalToSuperview().inset(41)
        }

        averageStepLabel.snp.makeConstraints {
            $0.top.equalTo(allStepCountLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(41)
        }

        averageStepNumLabel.snp.makeConstraints {
            $0.centerY.equalTo(averageStepLabel)
            $0.trailing.equalToSuperview().inset(41)
        }
    }

}
