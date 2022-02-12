import UIKit

import Pageboy
import Tabman
import RxSwift

class DetailHubViewController: TabmanViewController {

    private var viewController = [UIViewController]()

    private var disposeBag = DisposeBag()

    private let searchTableView = UITableView().then {
        $0.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        $0.register(RankTableViewCell.self, forCellReuseIdentifier: "searchCell")
    }

    private let searchBtn = UIBarButtonItem(
        image: .init(systemName: "magnifyingglass"),
        style: .plain,
        target: self,
        action: nil).then {
            $0.tintColor = .black
        }

    private let searchBar = UISearchController().then {
        $0.searchBar.setImage(UIImage(), for: .search, state: .normal)
        $0.searchBar.backgroundColor = .clear
        $0.searchBar.searchTextField.textAlignment = .left
        $0.searchBar.searchTextField.placeholder = "이름으로 검색하기"
        $0.searchBar.setValue("취소", forKey: "cancelButtonText")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addViewController()
        setTopTabbar()
    }

    override func viewWillAppear(_ animated: Bool) {
        searchTableView.isHidden = true
        setNavigation()
    }

    override func viewDidLayoutSubviews() {
        view.addSubview(searchTableView)

        searchTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    func addViewController() {
        let detailHubVC = RankViewController()
        let informationVC = InformationViewController()

        [detailHubVC, informationVC].forEach { viewController.append($0) }
    }

    func setTopTabbar() {
        self.dataSource = self

        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap

        bar.buttons.customize {
            $0.tintColor = .gray400
            $0.selectedTintColor = .black
            $0.font = .notoSansFont(ofSize: 16, family: .medium)
        }

        bar.layout.contentMode = .fit

        bar.indicator.tintColor = .primary400

        addBar(bar, dataSource: self, at: .top)
    }
}

extension DetailHubViewController: UISearchBarDelegate {
    private func setNavigation() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .gray50
        searchBar.searchBar.delegate = self

        searchBtn.rx.tap.subscribe(onNext: {
            self.navigationItem.searchController = self.searchBar
            Observable<Int>.interval(.seconds(0), scheduler: MainScheduler.instance)
                .subscribe(onNext: { _ in
                    self.searchBar.searchBar.searchTextField.becomeFirstResponder()
                }).disposed(by: self.disposeBag)
            self.searchTableView.isHidden = false
        }).disposed(by: disposeBag)

        navigationItem.rightBarButtonItem = searchBtn
        navigationController?.navigationBar.tintColor = .black
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.searchController = nil
        self.searchTableView.isHidden = true
    }

}

extension DetailHubViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        if index == 0 {
            return TMBarItem(title: "랭킹")
        } else {
            return TMBarItem(title: "정보")
        }
    }

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewController.count
    }

    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewController[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
}
