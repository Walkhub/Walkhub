import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import CoreGraphics

class HomeViewController: UIViewController {

    private var viewModel: HomeViewModel!
    private var disposeBag = DisposeBag()

    private let getData = PublishRelay<Void>()

    private let notificationBtn = UIBarButtonItem().then {
        $0.image = .init(systemName: "bell.fill")
        $0.tintColor = .black
    }

    private let mainTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .init(named: "F9F9F9")
        $0.register(HealthInfoTableViewCell.self, forCellReuseIdentifier: "cell")
        $0.register(RankTableViewCell.self, forCellReuseIdentifier: "secondCell")
        $0.register(RankTableViewCell.self, forCellReuseIdentifier: "thirdCell")
        $0.register(SeeMoreRankTableViewCell.self, forCellReuseIdentifier: "fourthCell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        mainTableView.delegate = self
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
            getMainData: getData.asDriver(onErrorJustReturn: ())
        )

        let output = viewModel.transform(input)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 64
        } else {
            return 50
        }
    }
}

extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
            return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 2 ? 2 : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = mainTableView.dequeueReusableCell(
                withIdentifier: "cell",
                for: indexPath
            ) as? HealthInfoTableViewCell
            cell?.selectionStyle = .none
            cell?.whCircleProgressView.progress = 80

            return cell!
        } else if indexPath.section == 1 {
            let cell = mainTableView.dequeueReusableCell(
                withIdentifier: "secondCell",
                for: indexPath
            ) as? StartExerciseMeasuringTableViewCell
            return cell!
        } else {
            if indexPath.row == 0 {
                let cell = mainTableView.dequeueReusableCell(
                    withIdentifier: "thirdCell",
                    for: indexPath
                ) as? RankTableViewCell
                return cell!
            } else {
                let cell = mainTableView.dequeueReusableCell(
                    withIdentifier: "fourthCell",
                    for: indexPath
                ) as? SeeMoreRankTableViewCell
                cell?.selectionStyle = .none
                return cell!
            }
        }
    }
}
