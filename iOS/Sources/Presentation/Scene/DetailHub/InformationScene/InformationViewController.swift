import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Service

class InformationViewController: UIViewController {

    var viewModel: InformationViewModel!
    var schoolId = Int()

    private let id = PublishRelay<Int>()
    private var disposeBag = DisposeBag()

    // MARK: UI
    private let headerView = InformationHeaderView().then {
        $0.backgroundColor = .white
        $0.layer.frame.size.height = 222
    }
    private let noticeTableView = UITableView().then {
        $0.register(SchoolNoticeTableViewCell.self, forCellReuseIdentifier: "noticeCell")
        $0.separatorStyle = .none
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setTableView()
        bind()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSubviews()
        makeSubviewConstraints()
    }
    override func viewDidAppear(_ animated: Bool) {
        id.accept(schoolId)
    }

    // MARK: - TableView
    private func setTableView() {
        noticeTableView.tableHeaderView = headerView
        noticeTableView.rowHeight = 60
    }

    // MARK: - Bind
    private func bind() {
        let input = InformationViewModel.Input(
            schoolId: id.asDriver(onErrorJustReturn: 0)
        )
        let output = viewModel.transform(input)

        output.schoolDetails.asObservable()
            .subscribe(onNext: {
                print("!!!")
                self.headerView.lastWeekTotalWalkCountAndUserCountLabel.text = "\($0.week.totalWalkCount.toString()) 걸음 \($0.week.totalUserCount)명"
                self.headerView.lastWeekDateLabel.text = $0.week.date.toString(dateFormat: "yyyy년 M월")
                self.setRanking($0.week.ranking, self.headerView.lastWeekBadgeImageView)
                self.headerView.lastWeekWalkCountRankingLabel.text = "\($0.week.ranking)등"
                self.headerView.lastMonthToalWalkCountAndUserCountLabel.text = "\($0.month.totalWalkCount.toString()) 걸음 \($0.month.totalUserCount)명"
                self.headerView.lastMonthDateLabel.text = $0.month.date.toString(dateFormat: "yyyy년 M월")
                self.setRanking($0.month.ranking, self.headerView.lastMonthBadgeImageView)
                self.headerView.lastMonthWalkCountRankingLabel.text = "\($0.month.ranking)등"
            }).disposed(by: disposeBag)

        output.noticeList.bind(to: noticeTableView.rx.items(
            cellIdentifier: "noticeCell",
            cellType: SchoolNoticeTableViewCell.self
        )) { _, items, cell in
            cell.titleLabel.text = items.title
            cell.dateLabel.text = items.createdAt.toString(dateFormat: "yyyy.MM.dd")
            }.disposed(by: disposeBag)
    }
}

// MARK: - Layout
extension InformationViewController {
    private func addSubviews() {
        view.addSubview(noticeTableView)
    }
    private func makeSubviewConstraints() {
        noticeTableView.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
