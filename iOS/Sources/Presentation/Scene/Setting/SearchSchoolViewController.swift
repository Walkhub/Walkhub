import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class SearchSchoolViewController: UIViewController {

    var viewModel: SearchSchoolViewModel!
    private var disposeBag = DisposeBag()

    private let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = "학교 이름 검색하기"
    }

    private let schoolTableView = UITableView().then {
        $0.register(SchoolListTableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidLayoutSubviews() {
        view.addSubview(schoolTableView)

        schoolTableView.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.searchController = searchController
    }

    private func bind() {
        let input = SearchSchoolViewModel.Input(
            search: (self.navigationItem.searchController?.searchBar.searchTextField.rx.text.orEmpty.asDriver())!,
            cellTap: schoolTableView.rx.itemSelected.asDriver()
        )

        let output = viewModel.transform(input)

        output.schoolList.bind(to: schoolTableView.rx.items(
            cellIdentifier: "cell",
            cellType: SchoolListTableViewCell.self
        )) { _, item, cell in
            cell.logoImgView.kf.setImage(with: item.logoImageUrl)
            cell.schoolNameLabel.text = item.name
        }.disposed(by: disposeBag)
    }
}
