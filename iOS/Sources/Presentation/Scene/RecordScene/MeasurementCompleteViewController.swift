import UIKit
import CarPlay

class MeasurementCompleteViewController: UIViewController {

    private let saveRecordImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    private let stepCountImgView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    private let stepCountLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
        $0.textColor = .white
    }
    private let calorieImgView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    private let calorieLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
        $0.textColor = .white
    }
    private let distanceImgView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    private let distanceLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
        $0.textColor = .white
    }
    private let speedImgView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    private let speedLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
        $0.textColor = .white
    }
    private let timeImgView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    private let timeLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
        $0.textColor = .white
    }

    private let completeBtn = UIBarButtonItem().then {
        $0.title = "완료"
        $0.tintColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        demoData()
        setNavigation()
        navigationItem.title = "기록저장"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
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
        stepCountImgView.image = .init(systemName: "clock.fill")
        calorieImgView.image = .init(systemName: "clock.fill")
        distanceImgView.image = .init(systemName: "clock.fill")
        speedImgView.image = .init(systemName: "clock.fill")
        timeImgView.image = .init(systemName: "clock.fill")
        stepCountLabel.text = "18920"
        timeLabel.text = "1h23m"
        calorieLabel.text = "711kcal"
        distanceLabel.text = "6km"
        speedLabel.text = "0.9m/s"
    }
}

extension MeasurementCompleteViewController {
    private func addsubViews() {
        [saveRecordImageView,
         stepCountImgView,
         stepCountLabel,
         calorieImgView,
         calorieLabel,
         distanceImgView,
         distanceLabel,
         speedImgView,
         speedLabel,
         timeImgView,
         timeLabel
        ].forEach { view.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        saveRecordImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        stepCountImgView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(32)
            $0.top.equalToSuperview().inset(600)
            $0.width.height.equalTo(24)
        }

        stepCountLabel.snp.makeConstraints {
            $0.leading.equalTo(stepCountImgView.snp.trailing).offset(16)
            $0.top.equalToSuperview().inset(597)
        }

        timeImgView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(32)
            $0.top.equalTo(stepCountLabel.snp.bottom).offset(20)
            $0.width.height.equalTo(24)
        }

        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(timeImgView.snp.trailing).offset(16)
            $0.top.equalTo(stepCountLabel.snp.bottom).offset(15)
        }

        calorieImgView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(32)
            $0.top.equalTo(timeImgView.snp.bottom).offset(20)
            $0.width.height.equalTo(24)
        }

        calorieLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(15)
            $0.leading.equalTo(calorieImgView.snp.trailing).offset(16)
        }

        distanceImgView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(32)
            $0.top.equalTo(calorieImgView.snp.bottom).offset(20)
            $0.width.height.equalTo(24)
        }

        distanceLabel.snp.makeConstraints {
            $0.leading.equalTo(distanceImgView.snp.trailing).offset(16)
            $0.top.equalTo(calorieLabel.snp.bottom).offset(15)
        }

        speedImgView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(32)
            $0.top.equalTo(distanceImgView.snp.bottom).offset(20)
            $0.width.height.equalTo(24)
        }

        speedLabel.snp.makeConstraints {
            $0.leading.equalTo(speedImgView.snp.trailing).offset(16)
            $0.top.equalTo(distanceLabel.snp.bottom).offset(15)
        }
    }
}
