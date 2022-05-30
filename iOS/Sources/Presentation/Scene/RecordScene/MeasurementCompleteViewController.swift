import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Service

class MeasurementCompleteViewController: UIViewController {

    var viewModel: MeasurementCompleteViewModel!
    var image = UIImage()
    private var disposeBag = DisposeBag()
    private let getData = PublishRelay<Void>()

    private var selectedFirstNum = 0
    private var selectedSecondNum = 0

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

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        navigationItem.title = "기록저장"
        bindViewModel()
    }
    override func viewDidLayoutSubviews() {
        addsubViews()
        makeSubviewConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        saveRecordImageView.image = image
        getData.accept(())
    }

    private func setNavigation() {
        navigationItem.rightBarButtonItem = completeBtn
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    private func bindViewModel() {
        let input = MeasurementCompleteViewModel.Input(
            getData: getData.asDriver(onErrorJustReturn: ()))

        let output = viewModel.transform(input)
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
