import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Service
import Kingfisher

class HubViewController: UIViewController {

    var viewModel: HubViewModel!
    private var disposeBag = DisposeBag()

    private let dateType = PublishRelay<DateType>()

    private let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = "학교 검색"
        $0.searchBar.layer.cornerRadius = 8
        $0.searchBar.showsCancelButton = false
        $0.navigationItem.hidesSearchBarWhenScrolling = false
    }

    private let searchTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.register(SchoolRegistrationTableViewCell.self, forCellReuseIdentifier: "searchCell")
    }

    private let mySchoolLabel = UILabel().then {
        $0.text = "내 학교"
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let mySchoolView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }

    private let schoolImgView = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    private let schoolName = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let gradeClassLabel = UILabel().then {
        $0.textColor = .gray800
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
    }

    private let mySchoolButton = UIButton(type: .system).then {
        $0.backgroundColor = .clear
    }

    private let top100Label = UILabel().then {
        $0.text = "걸음수 Top 100"
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let dropDownBtn = DropDownButton().then {
        $0.arr = ["최근 일주일", "최근 한 달"]
    }

    private let rankTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray50
        searchController.searchBar.searchTextField.delegate = self
        bind()
        setDropDown()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addSubviews()
        makeSubviewContraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigation()
        dateType.accept(.week)
        dropDownBtn.setTitle("최근 일주일    ", for: .normal)
        self.tabBarController?.tabBar.isHidden = false
        self.searchTableView.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.searchController.searchBar.searchTextField.endEditing(true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    private func setDropDown() {
        dropDownBtn.dropDown.selectionAction = { row, item in
            self.dropDownBtn.setTitle(" \(item)\t", for: .normal)
            self.dropDownBtn.dropDown.clearSelection()
            switch row {
            case 0:
                self.dateType.accept(.week)
            default:
                self.dateType.accept(.month)
            }
        }
    }

    private func bind() {
        let input = HubViewModel.Input(
            dateType: dateType.asDriver(onErrorJustReturn: .day),
            name: searchController.searchBar.searchTextField.rx.text.orEmpty.asDriver(),
            mySchoolViewDidTap: mySchoolButton.rx.tap.asDriver(),
            rankCellDidSelected: rankTableView.rx.itemSelected.asDriver(),
            searchCelDidSelected: searchTableView.rx.itemSelected.asDriver()
        )

        let output = viewModel.transform(input)

        output.schoolRank.bind(to: rankTableView.rx.items(
            cellIdentifier: "schoolRankCell",
            cellType: RankTableViewCell.self)
        ) { _, items, cell in
            cell.imgView.kf.setImage(with: items.logoImageUrl)
            cell.nameLabel.text = items.name
            cell.stepLabel.text = "총 \(items.walkCount) 걸음/\(items.userCount)"
            cell.rankLabel.text = "\(items.ranking)등"
            switch items.ranking {
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

        output.mySchoolRank.asObservable().subscribe(onNext: {
            self.schoolImgView.kf.setImage(with: $0.logoImageUrl)
            self.schoolName.text = $0.name
            if $0.grade == 0 || $0.classNum == 0 {
                self.gradeClassLabel.text = "현재 소속중인 반이 없어요."
            } else {
                self.gradeClassLabel.text = "\($0.grade)학년 \($0.classNum)반"
            }
        }).disposed(by: disposeBag)

        output.searchSchoolList.bind(to: searchTableView.rx.items(
            cellIdentifier: "searchCell",
            cellType: SchoolRegistrationTableViewCell.self)) { _, items, cell in
                cell.schoolLogoImageView.kf.setImage(with: items.logoImageUrl)
                cell.schoolNameLabel.text = items.name
            }.disposed(by: disposeBag)
    }
}

extension HubViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.searchTableView.isHidden = false
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.searchTableView.isHidden = true
    }
}

// MARK: - SetNavigation
extension HubViewController {
    func setNavigation() {
        let titleLabel = UILabel().then {
            $0.text = "허브"
            $0.textColor = .black
            $0.font = .notoSansFont(ofSize: 20, family: .medium)
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
        self.navigationItem.searchController = searchController
    }
}
// MARK: - Layout
extension HubViewController {
    private func addSubviews() {
        [mySchoolLabel, mySchoolView, top100Label, dropDownBtn, rankTableView, searchTableView]
            .forEach { view.addSubview($0) }

        [schoolImgView, schoolName, gradeClassLabel, mySchoolButton]
            .forEach { mySchoolView.addSubview($0) }
    }

    private func makeSubviewContraints() {
        mySchoolLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin).offset(10)
            $0.leading.equalToSuperview().inset(16)
        }

        mySchoolView.snp.makeConstraints {
            $0.top.equalTo(mySchoolLabel.snp.bottom).offset(9)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(64)
        }

        schoolImgView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(40)
        }

        schoolName.snp.makeConstraints {
            $0.top.equalToSuperview().inset(11)
            $0.leading.equalTo(schoolImgView.snp.trailing).offset(16)
        }

        gradeClassLabel.snp.makeConstraints {
            $0.top.equalTo(schoolName.snp.bottom)
            $0.leading.equalTo(schoolImgView.snp.trailing).offset(16)
        }

        mySchoolButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        top100Label.snp.makeConstraints {
            $0.top.equalTo(mySchoolView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }

        dropDownBtn.snp.makeConstraints {
            $0.top.equalTo(mySchoolView.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(36)
            $0.width.equalTo(94)
        }

        rankTableView.snp.makeConstraints {
            $0.top.equalTo(top100Label.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }

        searchTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
