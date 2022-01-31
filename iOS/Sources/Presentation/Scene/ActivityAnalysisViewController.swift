// swiftlint:disable line_length
// swiftlint:disable function_body_length
import UIKit

import SnapKit
import Then

class ActivityAnalysisViewController: UIViewController {

    private let scrollView = UIScrollView()

    private let backView = UIView()

    private let blueView = UIView().then {
        $0.backgroundColor = .init(named: "57B4F1")
    }

    private let imgView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = $0.bounds.width
    }

    private let foodLabel = UILabel().then {
        $0.text = "카페 라떼"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }

    private let kcalLabel = UILabel().then {
        $0.text = "180kcal"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }

    private let criteriaLabel = UILabel().then {
        $0.text = "(355ml 기준)"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }

    private let contentLabel = UILabel().then {
        $0.text = "\"커피 한잔 할래요~?\""
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }

    private let levelLabel = UILabel().then {
        $0.backgroundColor = .white
        $0.text = "Lv.7"
        $0.textColor = .init(named: "57B4F1")
        $0.font = .systemFont(ofSize: 12, weight: .regular)
    }

    private let levelProgressBarBackView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
    }

    private let levelProgressBar = UIProgressView().then {
        $0.trackTintColor = .white
        $0.progressTintColor = .init(named: "57B4F1")
        $0.progress = 0.0
    }

    private let whiteView = UIView().then {
        $0.backgroundColor = .white
    }

    private let dateLabel = UILabel().then {
        $0.text = "1월 14일 (금)"
        $0.textColor = .init(named: "8E8E8E")
    }

    private let stepCountLabel = UILabel().then {
        $0.text = "걸음수"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private let currentStepCountLabel = UILabel().then {
        $0.text = "6473/7000 걸음"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }

    private let stepCountProgressBackView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .init(named: "E5E5E5")
    }

    private let stepCountProgressBar = UIProgressView().then {
        $0.trackTintColor = .init(named: "E5E5E5")
        $0.progressTintColor = .init(named: "57B4F1")
        $0.progress = 0.0
    }

    private let burnKcalLabel = UILabel().then {
        $0.text = "칼로리 소모"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private let kcalContentLabel = UILabel().then {
        $0.text = "건강정보 기준으로 측정했어요"
    }

    private let kcalNumLabel2 = UILabel().then {
        $0.text = "203 Kcal"
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }

    private let distanceLabel = UILabel().then {
        $0.text = "거리"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    private let timeLabel = UILabel().then {
        $0.text = "시간"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    private let distanceNumLabel = UILabel().then {
        $0.text = "5.24km"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }

    private let timeNumLabel = UILabel().then {
        $0.text = "1h 10m"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 20, weight: .medium)
    }

    private let weekBtn = UIButton(type: .system).then {
        $0.backgroundColor = .init(named: "57B4F1")
        $0.tintColor = .white
        $0.setTitle("주간", for: .normal)
    }

    private let monthBtn = UIButton(type: .system).then {
        $0.backgroundColor = .init(named: "57B4F1")
        $0.tintColor = .white
        $0.setTitle("월간", for: .normal)
    }

    private let chart = UIView()

    private let allStepCountLabel = UILabel().then {
        $0.text = "걸음수 총합"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private let allStepCountNumLabel = UILabel().then {
        $0.text = "25382"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private let averageStepCountLabel = UILabel().then {
        $0.text = "평균 걸음 수"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private let averageStepCountNumLabel = UILabel().then {
        $0.text = "3626"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "활동분석"
    }

    override func viewDidLayoutSubviews() {
        setup()
    }

    private func setup() {
        view.addSubview(scrollView)

        scrollView.addSubview(backView)

        [whiteView, blueView].forEach { backView.addSubview($0) }

        [imgView, foodLabel, kcalLabel, criteriaLabel, contentLabel, levelProgressBarBackView, levelProgressBar, levelLabel]
            .forEach { blueView.addSubview($0) }

        [dateLabel, stepCountLabel, currentStepCountLabel, stepCountProgressBackView,
         stepCountProgressBar, burnKcalLabel, kcalContentLabel, kcalNumLabel2, distanceLabel,
         timeLabel, distanceNumLabel, timeNumLabel, weekBtn, monthBtn, chart, allStepCountLabel, allStepCountNumLabel, averageStepCountLabel, averageStepCountNumLabel].forEach { whiteView.addSubview($0) }

        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaInsets)
        }

        backView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }

        blueView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(92)
            $0.leading.trailing.equalToSuperview().inset(80)
            $0.height.equalTo(272)
        }

        whiteView.snp.makeConstraints {
            $0.top.equalTo(blueView.snp.bottom).inset(100)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        imgView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(14)
            $0.height.width.equalTo(112)
        }

        foodLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(136)
            $0.leading.equalToSuperview().inset(17)
        }

        kcalLabel.snp.makeConstraints {
            $0.top.equalTo(foodLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(17)
        }

        criteriaLabel.snp.makeConstraints {
            $0.top.equalTo(kcalLabel.snp.top).inset(9)
            $0.leading.equalTo(kcalLabel.snp.trailing).offset(5)
        }

        contentLabel.snp.makeConstraints {
            $0.top.equalTo(kcalLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(17)
        }

        levelLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(18)
            $0.width.equalTo(41)
            $0.height.equalTo(21)
        }

        levelProgressBarBackView.snp.makeConstraints {
            $0.centerY.equalTo(levelLabel)
            $0.leading.equalTo(levelLabel.snp.trailing).inset(3)
            $0.trailing.equalToSuperview().inset(17)
            $0.height.equalTo(11)
        }

        levelProgressBar.snp.makeConstraints {
            $0.centerY.equalTo(levelProgressBarBackView)
            $0.leading.equalTo(levelProgressBarBackView.snp.leading).inset(3)
            $0.trailing.equalTo(levelProgressBarBackView.snp.trailing).inset(3)
            $0.height.equalTo(5)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(121)
            $0.leading.equalToSuperview().inset(39)
        }

        stepCountLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(16)
            $0.leading.equalTo(dateLabel.snp.leading)
        }

        currentStepCountLabel.snp.makeConstraints {
            $0.top.equalTo(stepCountLabel.snp.bottom)
            $0.leading.equalTo(stepCountLabel.snp.leading)
        }

        stepCountProgressBackView.snp.makeConstraints {
            $0.top.equalTo(currentStepCountLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(39)
            $0.height.equalTo(11)
        }
        stepCountProgressBar.snp.makeConstraints {
            $0.top.equalTo(stepCountProgressBackView.snp.top).inset(3)
            $0.bottom.equalTo(stepCountProgressBackView.snp.bottom).inset(3)
            $0.leading.equalTo(stepCountProgressBackView.snp.leading).inset(3)
            $0.trailing.equalTo(stepCountProgressBackView.snp.trailing).inset(3)
        }

        burnKcalLabel.snp.makeConstraints {
            $0.top.equalTo(stepCountProgressBackView.snp.bottom).offset(13)
            $0.leading.equalToSuperview().inset(39)
        }

        kcalContentLabel.snp.makeConstraints {
            $0.top.equalTo(burnKcalLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(39)
        }

        kcalNumLabel2.snp.makeConstraints {
            $0.top.equalTo(kcalContentLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(39)
        }

        distanceLabel.snp.makeConstraints {
            $0.top.equalTo(kcalNumLabel2.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(85)
        }

        timeLabel.snp.makeConstraints {
            $0.top.equalTo(distanceLabel.snp.top)
            $0.trailing.equalToSuperview().inset(85)
        }

        distanceNumLabel.snp.makeConstraints {
            $0.top.equalTo(distanceLabel.snp.bottom).offset(4)
            $0.centerX.equalTo(distanceLabel)
        }

        timeNumLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
            $0.centerX.equalTo(timeLabel)
        }

        weekBtn.snp.makeConstraints {
            $0.top.equalTo(distanceNumLabel.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(100)
            $0.width.equalTo(81)
            $0.height.equalTo(28)
        }

        monthBtn.snp.makeConstraints {
            $0.top.equalTo(weekBtn.snp.top)
            $0.trailing.equalToSuperview().inset(100)
            $0.width.equalTo(81)
            $0.height.equalTo(28)
        }

        chart.snp.makeConstraints {
            $0.top.equalTo(monthBtn.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(45)
            $0.height.equalTo(115)
        }

        allStepCountLabel.snp.makeConstraints {
            $0.top.equalTo(chart.snp.bottom).offset(15)
            $0.leading.equalToSuperview().inset(41)
        }

        allStepCountNumLabel.snp.makeConstraints {
            $0.centerY.equalTo(allStepCountLabel)
            $0.trailing.equalToSuperview().inset(41)
        }

        averageStepCountLabel.snp.makeConstraints {
            $0.top.equalTo(allStepCountLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(41)
        }

        averageStepCountNumLabel.snp.makeConstraints {
            $0.centerY.equalTo(averageStepCountLabel)
            $0.trailing.equalToSuperview().inset(41)
        }
    }
}
