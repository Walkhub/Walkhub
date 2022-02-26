import UIKit

import Pageboy
import Tabman
import RxSwift
import RxCocoa

class DetailHubViewController: TabmanViewController {

    internal let schoolId = PublishRelay<Int>()

    private var viewController = [UIViewController]()

    private var rankVC: RankViewController!
    private var informationVC: InformationViewController!
    private var viewModel: DetailHubViewModel!

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
        [rankVC, informationVC].forEach { viewController.append($0) }
    }

    func setTopTabbar() {
        self.dataSource = self

        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.interButtonSpacing = 0

        bar.buttons.customize {
            $0.tintColor = .gray400
            $0.selectedTintColor = .black
            $0.font = .notoSansFont(ofSize: 16, family: .medium)
            $0.backgroundColor = .white
        }

        bar.layout.contentMode = .fit

        bar.indicator.tintColor = .primary400
        bar.indicator.weight = .custom(value: 1)

        addBar(bar, dataSource: self, at: .top)
    }

    private func bindViewModel() {
        let input = DetailHubViewModel.Input(
            name: searchBar.searchBar.searchTextField.rx.text.orEmpty.asDriver(),
            schoolId: schoolId.asDriver(onErrorJustReturn: 0),
            dateType: rankVC.dateType.asDriver(onErrorJustReturn: .day),
            switchOn: rankVC.scope.asDriver(onErrorJustReturn: .school),
            isMySchool: rankVC.isMySchool.asDriver(onErrorJustReturn: true),
            getDetails: informationVC.getDetails.asDriver(onErrorJustReturn: ())
        )
        let output = viewModel.transform(input)

        output.userList.bind(to: searchTableView.rx.items(
            cellIdentifier: "searchCell",
            cellType: RankTableViewCell.self)
        ) { _, item, cell in
            cell.imgView.image = item.profileImageUrl.toImage()
            cell.nameLabel.text = item.name
            cell.stepLabel.text = "\(item.walkCount) 걸음"
            cell.rankLabel.text = "\(item.ranking) 등"
            switch item.ranking {
            case 1:
                cell.badgeImgView.image = .init(named: "GoldBadgeImg")
            case 2:
                cell.badgeImgView.image = .init(named: "SilverBadgeImg")
            case 3:
                cell.badgeImgView.image = .init(named: "BronzeBadgeImg")
            default:
                cell.badgeImgView.image = UIImage()
            }
        }.disposed(by: disposeBag)

        output.myRank.asObservable().subscribe(onNext: {
            self.rankVC.myRank.accept($0)
        }).disposed(by: disposeBag)

        output.userList.asObservable().subscribe(onNext: {
            self.rankVC.userList.accept($0)
        }).disposed(by: disposeBag)

        output.defaultUserList.asObservable().subscribe(onNext: {
            self.rankVC.defaultUserList.accept($0)
        }).disposed(by: disposeBag)

        output.schoolDetails.asObservable().subscribe(onNext: {
            self.informationVC.schoolDetials.accept($0)
        }).disposed(by: disposeBag)
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

    func viewController(
        for pageboyViewController: PageboyViewController,
        at index: PageboyViewController.PageIndex
    ) -> UIViewController? {
        return viewController[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
}
