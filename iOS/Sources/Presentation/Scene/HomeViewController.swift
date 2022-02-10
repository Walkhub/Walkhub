import UIKit

import SnapKit
import Then
import RxCocoa
import CoreGraphics

class HomeViewController: UIViewController {

    private let cellView = UIView()

    private let notificationBtn = UIBarButtonItem().then {
        $0.image = .init(systemName: "bell.fill")
        $0.tintColor = .black
    }

    private let mainTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .init(named: "F9F9F9")
        $0.register(MainPageTableViewCell.self, forCellReuseIdentifier: "cell")
        $0.register(SecondMainpageTableViewCell.self, forCellReuseIdentifier: "secondCell")
        $0.register(RankTableViewCell.self, forCellReuseIdentifier: "thirdCell")
        $0.register(ThirdMainPageTableViewCell.self, forCellReuseIdentifier: "fourthCell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        layout()
        mainTableView.dataSource = self
    }

    private func setNavigation() {
        navigationItem.rightBarButtonItem = notificationBtn
        navigationItem.rightBarButtonItem!.tintColor = .black

        self.view.backgroundColor = .lightGray
    }

    override func viewDidLayoutSubviews() {
    }

    private func layout() {

        self.view.addSubview(mainTableView)
        self.view.addSubview(cellView)

        mainTableView.snp.makeConstraints {
            $0.top.trailing.leading.bottom.equalToSuperview()
        }
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
            ) as? MainPageTableViewCell
            cell?.selectionStyle = .none
            cell?.whCircleProgressView.progress = 80

            return cell!
        } else if indexPath.section == 1 {
            let cell = mainTableView.dequeueReusableCell(
                withIdentifier: "secondCell",
                for: indexPath
            ) as? SecondMainpageTableViewCell
            return cell!
        } else {
            if indexPath.row == 0 {
                let cell = mainTableView.dequeueReusableCell(
                    withIdentifier: "thirdCell",
                    for: indexPath
                ) as? RankTableViewCell
                cell?.demoData()
                return cell!
            } else {
                let cell = mainTableView.dequeueReusableCell(
                    withIdentifier: "fourthCell",
                    for: indexPath
                ) as? ThirdMainPageTableViewCell
                cell?.selectionStyle = .none
                return cell!
            }
        }
    }
}
