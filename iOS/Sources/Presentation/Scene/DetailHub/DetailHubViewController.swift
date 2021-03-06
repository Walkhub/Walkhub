import UIKit

import Pageboy
import Tabman
import RxSwift
import RxCocoa
import Service

class DetailHubViewController: TabmanViewController {

    var isMySchool = Bool()
    var schoolId = Int()
    var schoolName = String()

    private var viewController = [UIViewController]()

    var rankVC: RankViewController!
    var informationVC: InformationViewController!
    var anotherSchoolRankVC: AnotherSchoolRankViewController!
    var viewModel: DetailHubViewModel!

    private var disposeBag = DisposeBag()
    private let dateType = BehaviorRelay<DateType>(value: .day)

    // MARK: - UI
    private let searchTableView = UITableView().then {
        $0.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.4)
        $0.register(RankTableViewCell.self, forCellReuseIdentifier: "searchCell")
    }
    private let searchBtn = UIBarButtonItem(
        image: .init(systemName: "magnifyingglass"),
        style: .plain,
        target: DetailHubViewController.self,
        action: nil).then {
            $0.tintColor = .black
        }
    private let cancelButton = UIBarButtonItem(
        title: "취소",
        style: .plain,
        target: DetailHubViewController.self,
        action: nil).then {
            $0.tintColor = .black
        }
    private let searchBar = UISearchBar().then {
        $0.setImage(UIImage(), for: .search, state: .normal)
        $0.backgroundColor = .clear
        $0.searchTextField.textAlignment = .left
        $0.searchTextField.placeholder = "이름으로 검색하기"
        $0.setValue("취소", forKey: "cancelButtonText")
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.delegate = self
        setButton()
        rankVC.schoolId = self.schoolId
        informationVC.schoolId = self.schoolId
        anotherSchoolRankVC.schoolId = self.schoolId
        addViewController()
        setTopTabbar()
        bind()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        searchTableView.isHidden = true
        setNavigation()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(searchTableView)

        searchTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    // MARK: - Tabman
    func addViewController() {
        if isMySchool {
            [rankVC, informationVC].forEach { viewController.append($0) }
            rankVC.dateType
                .subscribe(onNext: {
                    self.dateType.accept($0)
                }).disposed(by: disposeBag)
        } else {
            [anotherSchoolRankVC, informationVC].forEach { viewController.append($0) }
            anotherSchoolRankVC.dateType
                .subscribe(onNext: {
                    self.dateType.accept($0)
                }).disposed(by: disposeBag)
        }
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

    // MARK: - Button
    private func setButton() {
        searchBtn.rx.tap.subscribe(on: MainScheduler.asyncInstance).subscribe(onNext: {
            self.navigationItem.titleView = self.searchBar
            self.searchBar.searchTextField.becomeFirstResponder()
            self.searchTableView.isHidden = false
        }).disposed(by: disposeBag)

        cancelButton.rx.tap.subscribe(onNext: {
            self.searchBar.searchTextField.endEditing(true)
        }).disposed(by: disposeBag)
    }

    // MARK: - Bind
    private func bind() {
        let input = DetailHubViewModel.Input(
            name: searchBar.searchTextField.rx.text.orEmpty.asDriver(),
            schoolId: schoolId,
            dateType: dateType,
            moveJoinClass: rankVC.joinClassBtn.rx.tap.asDriver()
            )
        let output = viewModel.transform(input)

        output.searchUserList.bind(to: searchTableView.rx.items(
            cellIdentifier: "searchCell", cellType: RankTableViewCell.self
        )) { _, item, cell in
            cell.imgView.kf.setImage(with: item.profileImageUrl)
            cell.nameLabel.text = item.name
            cell.rankLabel.text = "\(item.ranking)등"
            self.setRanking(item.ranking, cell.badgeImgView)
            cell.stepLabel.text = "\(item.walkCount)걸음"
        }.disposed(by: disposeBag)
    }
}

// MARK: - Navigation
extension DetailHubViewController {
    private func setNavigation() {
        self.title = schoolName
        self.navigationController?.navigationBar.setBackButtonToArrow()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .gray50
        self.navigationController?.navigationBar.backgroundColor = .systemBackground

        navigationItem.rightBarButtonItem = searchBtn
    }
}

// MARK: - TextField Delegate
extension DetailHubViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.navigationItem.rightBarButtonItem = cancelButton
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTableView.isHidden = true
        navigationItem.titleView = nil
        self.navigationItem.rightBarButtonItem = searchBtn
        self.navigationItem.setHidesBackButton(false, animated: true)
    }
}

// MARK: - Tabman & Pageboy
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
