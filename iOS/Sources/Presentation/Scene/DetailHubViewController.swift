import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
class DetailHubViewController: UIViewController {

    private var disposeBag = DisposeBag()

    private let searchTableView = UITableView().then {
        $0.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        $0.register(RankTableViewCell.self, forCellReuseIdentifier: "searchCell")
    }

    private let myViewBackground = UIView().then {
        $0.backgroundColor = .gray50
    }

    private let myView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }

    private let imgView = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.height / 2
        $0.contentMode = .scaleToFill
    }

    private let nameLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let stepCountLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }

    private let rankLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let rankTableView = UITableView().then {
        $0.backgroundColor = .gray50
        $0.separatorStyle = .none
        $0.register(RankTableViewCell.self, forCellReuseIdentifier: "rankCell")
    }

    private let joinClassBtn = UIButton(type: .system).then {
        $0.setTitle("반 등록하고 랭킹 확인하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 12
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray50
        demoDate()
        setTableView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSubviews()
        makeSubviewConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNavigation()
        searchTableView.isHidden = true
        joinClassBtn.isHidden = true
    }
}

extension DetailHubViewController: UISearchBarDelegate{

    private func setNavigation() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .gray50
        let searchBtn = UIBarButtonItem(
            image: .init(systemName: "magnifyingglass"),
            style: .plain,
            target: self,
            action: nil).then {
                $0.tintColor = .black
            }
        let searchBar = UISearchController().then {
            $0.searchBar.setImage(UIImage(), for: .search, state: .normal)
            $0.searchBar.backgroundColor = .clear
            $0.searchBar.searchTextField.textAlignment = .left
            $0.searchBar.searchTextField.placeholder = "이름으로 검색하기"
            $0.searchBar.setValue("취소", forKey: "cancelButtonText")
            searchBarCancelButtonClicked($0.searchBar)
            }

        searchBar.searchBar.delegate = self

        searchBtn.rx.tap.subscribe(onNext: {
            searchBar.searchBar.isHidden = false
            searchBar.searchBar.searchTextField.becomeFirstResponder()
        }).disposed(by: disposeBag)

        navigationItem.searchController = searchBar
        navigationItem.searchController?.searchBar.isHidden = true
        navigationItem.rightBarButtonItem = searchBtn
        navigationController?.navigationBar.tintColor = .black
        }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.isHidden = true
    }
}

// MARK: - Layout
extension DetailHubViewController {
    private func addSubviews() {
        [rankTableView, myViewBackground, searchTableView, joinClassBtn]
            .forEach { view.addSubview($0) }
        myViewBackground.addSubview(myView)

        [imgView, nameLabel, stepCountLabel, rankLabel].forEach { myView.addSubview($0) }
    }

    private func makeSubviewConstraints() {

        myViewBackground.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }

        myView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        searchTableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaInsets)
            $0.bottom.equalToSuperview()
        }

        imgView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(40)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imgView)
            $0.leading.equalTo(imgView.snp.trailing).offset(16)
        }

        stepCountLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalTo(nameLabel)
            $0.bottom.equalToSuperview().inset(11)
        }

        rankLabel.snp.makeConstraints {
            $0.centerY.equalTo(imgView)
            $0.trailing.equalToSuperview().inset(16)
        }

        rankTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        joinClassBtn.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
    }
}

extension DetailHubViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "rankCell", for: indexPath) as? RankTableViewCell
            cell?.nameLabel.text = "김시안"
            cell?.imgView.image = .init(systemName: "clock.fill")
            cell?.rankLabel.text = "1등"
            cell?.stepLabel.text = "8932 걸음"
            cell?.badgeImgView.image = .init(systemName: "bell.badge")

            return cell!
    }
}

extension DetailHubViewController {
    private func setTableView() {
        rankTableView.delegate = self
        rankTableView.dataSource = self

        rankTableView.rx.contentOffset
            .map { $0.y <= 90 }
            .subscribe(onNext: {
                self.myViewBackground.isHidden = $0
            }).disposed(by: disposeBag)
        rankTableView.tableHeaderView = HeaderView().then {
            $0.imgView.image = .init(systemName: "clock.fill")
            $0.nameLabel.text = "김기영"
            $0.stepCountLabel.text = "7483 걸음"
            $0.rankLabel.text = "5등"
            $0.progressBar.progress = 0.5
            $0.nextLevelLabel.text = "다음 등수까지 1290 걸음"
            $0.goalStepCountLabel.text = "2190 걸음"
            $0.layer.frame.size.height = 170
        }
        rankTableView.tableFooterView = FooterView().then {
            $0.commentLabel.text = "131명의 친구와 함께 뛰고 있어요"
            $0.layer.frame.size.height = 40
        }
    }

    private func demoDate() {
        imgView.image = .init(systemName: "clock.fill")
        nameLabel.text = "김기영"
        stepCountLabel.text = "5000 걸음"
        rankLabel.text = "7등"
    }
}
