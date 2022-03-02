import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import CoreGraphics

class HomeViewController: UIViewController {

    var viewModel: HomeViewModel!
    private var disposeBag = DisposeBag()

    private let getData = PublishRelay<Void>()
    private let moveAcitivityAnalysis = PublishRelay<Void>()
    private let moveRecordMeasurement = PublishRelay<Void>()

    private let healthInfoTableViewCell = HealthInfoTableViewCell()
    private let startRecordTalbeViewCell = StartExerciseMeasuringTableViewCell()
    private let rankTableViewCell = RankPreviewTableViewCell().then {
        $0.rankTableView.register(RankTableViewCell.self, forCellReuseIdentifier: "rankCell")
    }
    private let seeMoreRankTableViewCell = SeeMoreRankTableViewCell()

    private let notificationBtn = UIBarButtonItem().then {
        $0.image = .init(systemName: "bell.fill")
        $0.tintColor = .black
    }

    private let mainTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .gray50
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        bindViewModel()
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        getData.accept(())
    }

    override func viewDidLayoutSubviews() {
        self.view.addSubview(mainTableView)

        mainTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setNavigation() {
        navigationItem.rightBarButtonItem = notificationBtn
        navigationItem.rightBarButtonItem!.tintColor = .black

        self.view.backgroundColor = .lightGray
    }

    private func bindViewModel() {
        let input = HomeViewModel.Input(
            getMainData: getData.asDriver(onErrorJustReturn: ()),
            moveActivityAnalysis: moveAcitivityAnalysis.asDriver(onErrorJustReturn: ()),
            moveRecordMeasurement: moveRecordMeasurement.asDriver(onErrorJustReturn: ())
        )

        let output = viewModel.transform(input)

        rankTableViewCell.setup(userList: output.rankList)

        healthInfoTableViewCell.setup(
            dailyExercisesData: output.mainData,
            caloriesData: output.caloriesData,
            exerciseAnalysis: output.goalData
        )
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 400
        case 1:
            return 96
        default:
            return 250
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return healthInfoTableViewCell
        } else if indexPath.section == 1 {
            return startRecordTalbeViewCell
        } else {
            if indexPath.row == 0 {
                return rankTableViewCell
            } else {
                return seeMoreRankTableViewCell
            }
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            moveAcitivityAnalysis.accept(())
        } else if indexPath.section == 1 {
            moveRecordMeasurement.accept(())
        }
    }
}
