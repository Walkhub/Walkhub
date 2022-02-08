import UIKit

class DetailHubViewController: UIViewController {

    private let schoolLabel = UILabel().then {
        $0.text = "학교"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let switches = UISwitch().then {
        $0.isOn = false
        $0.onTintColor = .primary400
        $0.transform = CGAffineTransform(scaleX: 0.9, y: 0.8)
    }

    private let classLabel = UILabel().then {
        $0.text = "반"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let dropDownBtn = DropDownButton().then {
        $0.setTitle(" 오늘\t", for: .normal)
        $0.arr = ["오늘", "이번주", "이번달"]
        $0.setAction()
    }

    private let rankTableView = UITableView().then {
        $0.backgroundColor = .gray50
        $0.separatorStyle = .none
        $0.register(RankTableViewCell.self, forCellReuseIdentifier: "rankCell")
        $0.register(MyRankTableViewCell.self, forCellReuseIdentifier: "myRankCell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        rankTableView.dataSource = self
        rankTableView.delegate = self
        view.backgroundColor = .gray50
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSubviews()
        makeSubviewConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNavigation()
    }
}

extension DetailHubViewController {
    private func setNavigation() {
        let searchBtn = UIBarButtonItem(
            image: .init(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: nil).then {
                $0.tintColor = .black
            }
        let searchBar = UISearchBar().then {
            $0.setImage(UIImage(), for: .search, state: .normal)
            $0.searchTextField.backgroundColor = .clear
            $0.searchTextField.textAlignment = .center
            }
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = searchBtn
        }
    }

// MARK: - Layout
extension DetailHubViewController {
    private func addSubviews() {
        [schoolLabel, switches, classLabel, dropDownBtn, rankTableView]
            .forEach { view.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        schoolLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(116)
            $0.leading.equalTo(16)
        }

        switches.snp.makeConstraints {
            $0.centerY.equalTo(schoolLabel)
            $0.leading.equalTo(schoolLabel.snp.trailing).offset(8)
        }

        classLabel.snp.makeConstraints {
            $0.top.equalTo(schoolLabel)
            $0.leading.equalTo(switches.snp.trailing).offset(8)
        }

        dropDownBtn.snp.makeConstraints {
            $0.centerY.equalTo(schoolLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        rankTableView.snp.makeConstraints {
            $0.top.equalTo(classLabel.snp.bottom).offset(17)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension DetailHubViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 12
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myRankCell", for: indexPath) as? MyRankTableViewCell
            cell?.profileImgView.image = .init(systemName: "clock.fill")
            cell?.nameLabel.text = "김기영"
            cell?.stepCountLabel.text = "12319 걸음"
            cell?.progressBar.progress = 0.8
            cell?.nextLevelLabel.text = "다음 등수까지 1394 걸음"
            cell?.goalStepCountLabel.text = "8900 걸음"

            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "rankCell", for: indexPath) as? RankTableViewCell
            cell?.nameLabel.text = "김시안"
            cell?.imgView.image = .init(systemName: "clock.fill")
            cell?.rankLabel.text = "1등"
            cell?.stepLabel.text = "8932 걸음"
            cell?.badgeImgView.image = .init(systemName: "bell.badge")

            return cell!
        }
    }
}
