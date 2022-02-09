import UIKit

import SnapKit
import Then
import RxCocoa
import CoreGraphics

class HomeViewController: UIViewController {
    
    private let tableFooterView = UIView()

    private let notificationBtn = UIBarButtonItem().then {
        $0.image = .init(systemName: "bell.fill")
        $0.tintColor = .black
    }

    private let mainTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .init(named: "F9F9F9")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = notificationBtn
        navigationItem.rightBarButtonItem!.tintColor = .black

        self.view.backgroundColor = .lightGray
    }

    override func viewDidLayoutSubviews() {
        setUp()
    }

    private func attribute() {
        tableFooterView.backgroundColor = .purple
    }

    private func setUp() {
        attribute()
        layout()
    }

    private func layout() {

        self.view.addSubview(mainTableView)

        mainTableView.snp.makeConstraints {
            $0.top.trailing.leading.bottom.equalToSuperview()

            mainTableView.register(MainPageTableViewCell.self, forCellReuseIdentifier: "cell")
            mainTableView.register(SecondMainpageTableViewCell.self, forCellReuseIdentifier: "secondCell")
            mainTableView.register(RankTableViewCell.self, forCellReuseIdentifier: "thirdCell")
            mainTableView.dataSource = self
        }
        footerViewLayout()
    }

    private func footerViewLayout() {
      tableFooterView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 100)
    }
}

extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
            return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainPageTableViewCell

            cell?.whCircleProgressView.progress = 80

            return cell!
        } else if indexPath.section == 1 {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as? SecondMainpageTableViewCell

            return cell!
        } else {
            let cell = mainTableView.dequeueReusableCell(withIdentifier: "thirdCell", for: indexPath) as? RankTableViewCell
            
            return cell!
        }
    }
}
