import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Service

class AnotherSchoolRankViewController: UIViewController {

    var viewModel: AnotherSchoolRankViewModel!
    var schoolId = Int()

    private var disposeBag = DisposeBag()
    private let dateType = PublishRelay<DateType>()

    // MARK: - UI
    private let anotherSchoolHeaderView = AnotherSchoolRankHeaderView().then {
        $0.frame.size.height = 48
    }
    private let rankTableView = UITableView().then {
        $0.register(RankTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    private let footerView = RankCommentFooterView().then {
        $0.layer.frame.size.height = 40
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setDropdown()
        bind()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSubviews()
        makeSubviewConstraints()
    }
    override func viewDidAppear(_ animated: Bool) {
        print("\(schoolId) 어나더 랭킹")
        dateType.accept(.day)
    }

    // MARK: - Set TableView
    private func setTableView() {
        rankTableView.tableHeaderView = anotherSchoolHeaderView
        rankTableView.tableFooterView = footerView
    }

    // MARK: - Bind
    private func bind() {
        let input = AnotherSchoolRankViewModel.Input(
            schoold: schoolId,
            dateType: dateType.asDriver(onErrorJustReturn: .day))
        let output = viewModel.transform(input)

        output.userRankList.bind(to: rankTableView.rx.items(
            cellIdentifier: "cell",
            cellType: RankTableViewCell.self)) { _, items, cell in
                cell.imgView.kf.setImage(with: items.profileImageUrl)
                cell.nameLabel.text = items.name
                cell.rankLabel.text = "\(items.ranking)등"
                cell.stepLabel.text = "\(items.walkCount) 걸음"
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
    }
}

// MARK: - Layout
extension AnotherSchoolRankViewController {
    private func addSubviews() {
        view.addSubview(rankTableView)
    }
    private func makeSubviewConstraints() {
        rankTableView.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - Set Dropdown
extension AnotherSchoolRankViewController {
    private func setDropdown() {
        anotherSchoolHeaderView.dropDownBtn.dropDown.selectionAction = { row, item in
            self.anotherSchoolHeaderView.dropDownBtn.setTitle(" \(item)\t", for: .normal)
            self.anotherSchoolHeaderView.dropDownBtn.dropDown.clearSelection()
            switch row {
            case 0:
                self.dateType.accept(.day)
            case 1:
                self.dateType.accept(.week)
            default:
                self.dateType.accept(.month)
            }
        }
    }
}
