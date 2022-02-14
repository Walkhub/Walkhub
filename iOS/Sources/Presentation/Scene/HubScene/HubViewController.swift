import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class HubViewController: UIViewController {

    private var viewModel: HubViewModel
    private var disposeBag = DisposeBag()

    private let dayData = PublishRelay<Void>()
    private let weekData = PublishRelay<Void>()
    private let monthData = PublishRelay<Void>()

    private let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = "학교 검색"
        $0.searchBar.layer.cornerRadius = 8
        $0.navigationItem.hidesSearchBarWhenScrolling = false
        $0.hidesNavigationBarDuringPresentation = false
        $0.automaticallyShowsCancelButton = false
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

    private let top100Label = UILabel().then {
        $0.text = "걸음수 Top 100"
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let dropDownBtn = DropDownButton().then {
        $0.setTitle(" 어제\t", for: .normal)
        $0.arr = ["어제", "이번주", "이번달"]
        $0.setAction()
    }

    private let rankTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.separatorStyle = .none
        $0.register(RankTableViewCell.self, forCellReuseIdentifier: "schoolRankCell")
    }

    convenience init(viewModel: HubViewModel) {
        self.init(viewModel: viewModel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray50
        rankTableView.dataSource = self
        setNavigation()
        demoData()
        bindViewModel()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewContraints()
    }

    private func bindViewModel() {
        let input = HubViewModel.Input(
            dayData: dayData.asDriver(onErrorJustReturn: ()),
            weekData: weekData.asDriver(onErrorJustReturn: ()),
            monthData: monthData.asDriver(onErrorJustReturn: ())
        )

        let output = viewModel.transform(input)

        output.schoolRank.bind(to: rankTableView.rx.items(
            cellIdentifier: "schoolRankCell",
            cellType: RankTableViewCell.self)
        ) { _, items, cell in
            let data = try? Data(contentsOf: items.logoImageUrl)
            cell.imgView.image = .init(data: data!)
            cell.nameLabel.text = items.name
            cell.stepLabel.text = "총 \(items.walkCount) 걸음/\(items.studentsCount)"
            cell.rankLabel.text = "\(items.ranking)등"
        }.disposed(by: disposeBag)

        output.mySchoolRank.asObservable().subscribe(onNext: {
            let data = try? Data(contentsOf: $0.logoImageUrlString)
            self.schoolImgView.image = UIImage(data: data!)
            self.schoolName.text = $0.name
            self.gradeClassLabel.text = "\($0.grade)학년 \($0.classNum)반"
        }).disposed(by: disposeBag)
    }
}

extension HubViewController {
    private func demoData() {
        schoolImgView.image = .init(systemName: "clock.fill")
        schoolName.text = "대덕소프트웨어마이스터고등학교"
        gradeClassLabel.text = "3학년 3반"
    }

    private func setNavigation() {
        navigationItem.searchController = searchController
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.text = "허브"
        titleLabel.font = .notoSansFont(ofSize: 20, family: .medium)
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
       self.navigationItem.titleView = titleLabel
       guard let containerView = self.navigationItem.titleView?.superview else { return }

        let leftBarItemWidth = self.navigationItem.leftBarButtonItems?.reduce(0, { $0 + $1.width })
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor,
                                            constant: (leftBarItemWidth ?? 0) + 16),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor)
               ])
    }
}

// MARK: - Layout
extension HubViewController {
    private func addSubviews() {
        [mySchoolLabel, mySchoolView, top100Label, dropDownBtn, rankTableView]
            .forEach { view.addSubview($0) }

        [schoolImgView, schoolName, gradeClassLabel]
            .forEach { mySchoolView.addSubview($0) }
    }

    private func makeSubviewContraints() {
        mySchoolLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).offset(140)
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
    }
}
