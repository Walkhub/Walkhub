import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Service

class SearchSchoolViewController: UIViewController {
    var viewModel: SearchSchoolViewModel!
    var schoolInfo = PublishRelay<SearchSchool>()

    private var disposeBag = DisposeBag()

    let searchBar = UISearchBar().then {
        $0.placeholder = "학교 이름 검색하기"
    }

    let schoolTableView = UITableView().then {
        $0.register(SchoolListTableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
    }

    override func viewDidLayoutSubviews() {
        view.addSubview(schoolTableView)

        schoolTableView.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        self.navigationItem.titleView = searchBar
        self.searchBar.searchTextField.becomeFirstResponder()
    }

    private func bind() {
        let input = SearchSchoolViewModel.Input(
            search: searchBar.searchTextField.rx.text.orEmpty.asDriver(),
            cellSelected: schoolTableView.rx.itemSelected.asDriver()
        )
        let output = viewModel.transform(input)

        output.searchSchool.bind(to: schoolTableView.rx.items(
            cellIdentifier: "cell",
            cellType: SchoolListTableViewCell.self
        )) { _, item, cell in
            cell.logoImgView.kf.setImage(with: item.logoImageUrl)
            cell.schoolNameLabel.text = item.name
        }.disposed(by: disposeBag)

        output.schoolInfo.asObservable()
            .subscribe(onNext: {
                self.schoolInfo.accept($0)
            }).disposed(by: disposeBag)
    }
}
