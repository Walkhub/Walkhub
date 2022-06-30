import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Service

class SaveRecordViewController: UIViewController {

    var viewModel: MeasurementCompleteViewModel!
    private var disposeBag = DisposeBag()
    private let getData = PublishRelay<Void>()

    private var selectedFirstNum = 0
    private var selectedSecondNum = 0

    private let saveRecordImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }

    private let completeBtn = UIBarButtonItem().then {
        $0.title = "완료"
        $0.tintColor = .white
    }

    private let exerciseRecordView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 15
    }

    private let exerciseRecordLabel = UILabel().then {
        $0.text = "운동기록"
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let distanceLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let goalRecordLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let myRecordLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let slashLabel = UILabel().then {
        $0.text = "/"
    }

    private let recordProgressView = UIProgressView().then {
        $0.trackTintColor = .gray300
        $0.progress = 0.5
    }

    private let stepCountLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
        $0.text = "걸음수"
    }

    private let calorieLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
        $0.text = "칼로리"
    }

    private let speedLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
        $0.text = "속도"
    }

    private let timeLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
        $0.text = "시간"
    }

    private let stepRecordLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let calorieRecordLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let speedRecordLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let hoursRecordLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let minutesRecordLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let kcalLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.text = "kcal"
    }

    private let meterPerSecondLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.text = "m/s"
    }

    private let hoursLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.text = "h"
    }

    private let minutesLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.text = "m"
    }

    private let betweenLine = UIView().then {
        $0.backgroundColor = .gray200
    }

    private let bottomBetweenLine = UIView().then {
        $0.backgroundColor = .gray200
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        demoData()
        setNavigation()
        navigationItem.title = "기록저장"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        bindViewModel()
    }

    private func setNavigation() {
        navigationItem.rightBarButtonItem = completeBtn
    }

    override func viewDidLayoutSubviews() {
        addsubViews()
        makeSubviewConstraints()
    }

    private func demoData() {
        saveRecordImageView.backgroundColor = .gray
        saveRecordImageView.image = .init(systemName: "clock.fill")
        goalRecordLabel.text = "6km"
        myRecordLabel.text = "6km"
        stepRecordLabel.text = "18920"
        calorieRecordLabel.text = "711"
        speedRecordLabel.text = "0.9"
        hoursRecordLabel.text = "1"
        minutesRecordLabel.text = "23"
    }

    private func bindViewModel() {
        let input = MeasurementCompleteViewModel.Input(
            getData: getData.asDriver(onErrorJustReturn: ()))

        let output = viewModel.transform(input)
    }
}

extension SaveRecordViewController {
    private func addsubViews() {
        [saveRecordImageView,
         exerciseRecordView,
         exerciseRecordLabel,
         myRecordLabel,
         goalRecordLabel,
         slashLabel,
         recordProgressView,
         stepCountLabel,
         calorieLabel,
         speedLabel,
         timeLabel,
         betweenLine,
         stepRecordLabel,
         calorieRecordLabel,
         kcalLabel,
         bottomBetweenLine,
         speedRecordLabel,
         meterPerSecondLabel,
         hoursRecordLabel,
         hoursLabel,
         minutesRecordLabel,
         minutesLabel
        ].forEach { view.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        saveRecordImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        exerciseRecordView.snp.makeConstraints {
            $0.height.equalTo(400)
            $0.bottom.trailing.leading.equalTo(0)
        }

        exerciseRecordLabel.snp.makeConstraints {
            $0.top.equalTo(exerciseRecordView.snp.top).offset(12)
            $0.centerX.equalToSuperview()
        }

        myRecordLabel.snp.makeConstraints {
            $0.top.equalTo(exerciseRecordView.snp.top).offset(44)
            $0.leading.equalToSuperview().inset(39)
        }

        goalRecordLabel.snp.makeConstraints {
            $0.top.equalTo(exerciseRecordView.snp.top).offset(50)
            $0.leading.equalTo(myRecordLabel.snp.trailing).offset(5)
        }

        slashLabel.snp.makeConstraints {
            $0.top.equalTo(exerciseRecordView.snp.top).inset(50)
            $0.leading.equalTo(myRecordLabel.snp.trailing).offset(1)
        }

        recordProgressView.snp.makeConstraints {
            $0.top.equalTo(myRecordLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(39)
        }

        stepCountLabel.snp.makeConstraints {
            $0.top.equalTo(recordProgressView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(80)
        }

        calorieLabel.snp.makeConstraints {
            $0.top.equalTo(recordProgressView.snp.bottom).offset(32)
            $0.trailing.equalToSuperview().inset(80)
        }

        speedLabel.snp.makeConstraints {
            $0.top.equalTo(stepCountLabel.snp.bottom).offset(60)
            $0.leading.equalToSuperview().inset(80)
        }

        timeLabel.snp.makeConstraints {
            $0.top.equalTo(calorieLabel.snp.bottom).offset(60)
            $0.trailing.equalToSuperview().inset(80)
        }

        stepRecordLabel.snp.makeConstraints {
            $0.top.equalTo(stepCountLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(69)
        }

        betweenLine.snp.makeConstraints {
            $0.top.equalTo(recordProgressView.snp.bottom).offset(50)
            $0.height.equalTo(28)
            $0.width.equalTo(1)
            $0.centerX.equalToSuperview()
        }

        calorieRecordLabel.snp.makeConstraints {
            $0.top.equalTo(calorieLabel.snp.bottom).offset(4)
            $0.trailing.equalTo(kcalLabel.snp.leading).offset(-4)
        }

        kcalLabel.snp.makeConstraints {
            $0.top.equalTo(calorieLabel.snp.bottom).offset(12)
            $0.trailing.equalToSuperview().inset(66)
        }

        speedRecordLabel.snp.makeConstraints {
            $0.top.equalTo(speedLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(69)
        }

        meterPerSecondLabel.snp.makeConstraints {
            $0.top.equalTo(speedLabel.snp.bottom).offset(12)
            $0.leading.equalTo(speedRecordLabel.snp.trailing).offset(4)
        }

        bottomBetweenLine.snp.makeConstraints {
            $0.top.equalTo(betweenLine.snp.bottom).offset(50)
            $0.height.equalTo(28)
            $0.width.equalTo(1)
            $0.centerX.equalToSuperview()
        }

        minutesRecordLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
            $0.trailing.equalTo(minutesLabel.snp.leading).offset(-2)
        }

        minutesLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(11)
            $0.trailing.equalToSuperview().inset(67)
        }

        hoursLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(11)
            $0.trailing.equalTo(minutesRecordLabel.snp.leading).offset(-4)
        }

        hoursRecordLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
            $0.trailing.equalTo(hoursLabel.snp.leading).offset(-2)
        }
    }
}
