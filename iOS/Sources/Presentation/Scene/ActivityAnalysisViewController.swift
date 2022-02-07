// swiftlint:disable function_body_length
import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class ActivityAnalysisViewController: UIViewController {

    private var disposeBag = DisposeBag()

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
        $0.text = "걸음수"
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
        $0.text = "칼로리 소모"
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let kcalCommentLabel = UILabel().then {
        $0.text = "건강정보를 기준으로 측정했어요"
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
        $0.text = "거리"
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

    private let line = UIView().then {
        $0.backgroundColor = .gray100
    }

    private let weekBtn = UIButton().then {
        $0.setTitle("주간", for: .normal)
        $0.isSelected = true
        $0.setBackgroundColor(.primary400, for: .selected)
        $0.setTitleColor(.white, for: .selected)
        $0.setTitleColor(.gray400, for: .normal)
        $0.setBackgroundColor(.white, for: .normal)
        $0.layer.cornerRadius = 14
        $0.clipsToBounds = true
    }

    private let monthBtn = UIButton().then {
        $0.setTitle("월간", for: .normal)
        $0.setBackgroundColor(.primary400, for: .selected)
        $0.setBackgroundColor(.white, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.setTitleColor(.gray400, for: .normal)
        $0.layer.cornerRadius = 14
        $0.clipsToBounds = true
    }

    private let charts = ChartView()

    private let allStepCountLabel = UILabel().then {
        $0.text = "걸음 수 총합"
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let allStepCountNumLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let averageStepLabel = UILabel().then {
        $0.text = "평균 걸음 수"
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let averageStepNumLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "활동분석"
        view.backgroundColor = .gray50
        demoData()
        setBtn()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
        blueView.roundCorners(cornerRadius: 64, byRoundingCorners: .topRight)
        imgView.layer.shadowPath = UIBezierPath(
            roundedRect: imgView.bounds,
            cornerRadius: imgView.frame.width / 2).cgPath
    }
}

extension ActivityAnalysisViewController {
    private func demoData() {
        imgView.image = .init(systemName: "clock.fill")
        imgView.tintColor = .white
        foodName.text = "카페 라떼"
        foodKcalLabel.text = "180"
        criteriaLabel.text = "(355ml 기준)"
        commentLabel.text = "\"커피 한 잔 할래요~?\""
        levelLabel.text = "Lv.7"
        dateLabel.text = "1월 14일(금)"
        currentStepCountsLabel.text = "6700"
        goalStepCountLabel.text = "/7000 걸음"
        burnKcalNumLabel.text = "203"
        distanceNumLabel.text = "5.24"
        hourLabel.text = "1"
        minuteLabel.text = "15"
        charts.setMothCharts(stepCounts: [5000, 3244, 12321, 4400, 9877, 1233, 8888,
                                          5000, 3244, 12321, 4400, 9877, 1233, 8888,
                                          5000, 3244, 12321, 4400, 9877, 1233, 8888,
                                          5000, 3244, 12321, 4400, 9877, 1233, 8888])
        allStepCountNumLabel.text = "25382"
        averageStepNumLabel.text = "3626"
    }

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

// MARK: -Layout
extension ActivityAnalysisViewController {
    private func addSubviews() {
    view.addSubview(scrollView)

    scrollView.addSubview(contentView)

    [whiteView, blueView].forEach { contentView.addSubview($0) }

    [imgView, foodName, foodKcalLabel, kcalLabel, criteriaLabel,
     commentLabel, levelProgressBarBackView, levelProgressBar, levelLabel]
        .forEach { blueView.addSubview($0) }

    [dateLabel, stepCountLabel, currentStepCountsLabel, goalStepCountLabel, stepCountProgressBackView, stepCountProgressBar, burnKcalLaebel,
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
