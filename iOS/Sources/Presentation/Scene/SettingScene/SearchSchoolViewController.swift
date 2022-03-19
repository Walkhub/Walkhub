import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class SearchSchoolViewController: UIViewController {

    private var disposeBag = DisposeBag()

    let searchController = UISearchController(searchResultsController: nil).then {
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

}
