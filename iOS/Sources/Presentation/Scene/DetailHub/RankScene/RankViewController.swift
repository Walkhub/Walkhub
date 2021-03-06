import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Service

class RankViewController: UIViewController {

    var viewModel: RankViewModel!
    var schoolId = Int()

    private var disposeBag = DisposeBag()
    internal let groupScope = PublishRelay<GroupScope>()
    internal let dateType = BehaviorRelay<DateType>(value: .day)

    // MARK: - UI
    private let mySchoolHeaderView = RankHeaderView().then {
        $0.layer.frame.size.height = 180
    }
    private let footerView = RankCommentFooterView().then {
        $0.layer.frame.size.height = 40
    }
    private let myViewBackground = UIView().then {
        $0.backgroundColor = .gray50
    }
    private let myView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }
    private let imgView = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.height / 2
        $0.contentMode = .scaleToFill
    }
    private let badgeImgView = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.width / 2
        $0.contentMode = .scaleToFill
    }
    private let nameLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }
    private let stepCountLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }
    private let rankLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }
    private let rankTableView = UITableView().then {
        $0.backgroundColor = .gray50
        $0.separatorStyle = .none
        $0.register(RankTableViewCell.self, forCellReuseIdentifier: "rankCell")
    }
    internal let joinClassBtn = UIButton(type: .system).then {
        $0.setBackgroundColor(.primary400, for: .normal)
        $0.setTitle("반 등록하고 랭킹 확인하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 12
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray50
        setTableView()
        bind()
        addSubviews()
        makeSubviewConstraints()
        setDropDownAndSwitch()
    }
    override func viewWillAppear(_ animated: Bool) {
        dateType.accept(.day)
        groupScope.accept(.class)
    }
    override func viewDidLayoutSubviews() {
        joinClassBtn.clipsToBounds = true
    }

    // MARK: DropDown & Switch
    private func setDropDownAndSwitch() {
        mySchoolHeaderView.dropDownBtn.dropDown.selectionAction = { row, item in
            self.mySchoolHeaderView.dropDownBtn.setTitle(" \(item)\t", for: .normal)
            self.mySchoolHeaderView.dropDownBtn.dropDown.clearSelection()
            switch row {
            case 0:
                self.dateType.accept(.day)
            case 1:
                self.dateType.accept(.week)
            default:
                self.dateType.accept(.month)
            }
        }
        mySchoolHeaderView.switches.rx.isOn
            .subscribe(onNext: {
                if $0 {
                    self.groupScope.accept(.class)
                } else {
                    self.groupScope.accept(.school)
                }
            }).disposed(by: disposeBag)
    }

    // MARK: - Bind
    private func bind() {
        let input = RankViewModel.Input(
            schoolId: schoolId,
            dateType: dateType.asDriver(onErrorJustReturn: .day),
            groupScope: groupScope.asDriver(onErrorJustReturn: .class)
        )
        let output = viewModel.transform(input)

        output.myRank.asObservable().subscribe(onNext: { rank, num in
            self.mySchoolHeaderView.imgView.kf.setImage(with: rank.profileImageUrl)
            self.mySchoolHeaderView.nameLabel.text = rank.name + "(나)"
            output.isJoined.subscribe(onNext: {
                if $0 {
                    if rank.ranking != 1 {
                        self.mySchoolHeaderView.nextLevelLabel.text = "다음 등수까지 \(num ?? 0 - rank.walkCount) 걸음"
                        self.mySchoolHeaderView.goalStepCountLabel.text = "\(num ?? 0) 걸음"
                        self.mySchoolHeaderView.progressBar.progress = Float(rank.walkCount / (num ?? 1))
                        self.stepCountLabel.text = "\(rank.walkCount) 걸음"
                        self.rankLabel.text = "\(rank.ranking)등"
                        self.mySchoolHeaderView.rankLabel.text = "\(rank.ranking)등"
                        self.mySchoolHeaderView.stepCountLabel.text = "\(rank.walkCount) 걸음"
                    }
                    switch rank.ranking {
                    case 1:
                        self.mySchoolHeaderView.badgeImgView.image = .init(named: "GoldBadgeImg")
                        self.badgeImgView.image = .init(named: "GoldBadgeImg")
                        self.mySchoolHeaderView.nextLevelLabel.text = "최고 등수를 달성했어요!"
                        self.mySchoolHeaderView.goalStepCountLabel.text = "\(rank.walkCount) 걸음"
                        self.mySchoolHeaderView.progressBar.progress = 1
                    case 2:
                        self.mySchoolHeaderView.badgeImgView.image = .init(named: "SilverBadgeImg")
                        self.badgeImgView.image = .init(named: "SilverBadgeImg")
                    case 3:
                        self.mySchoolHeaderView.badgeImgView.image = .init(named: "BronzeBadgeImg")
                        self.badgeImgView.image = .init(named: "BronzeBadgeImg")
                    default:
                        self.mySchoolHeaderView.badgeImgView.image = UIImage()
                        self.badgeImgView.image = UIImage()
                    }
                } else {
                    self.mySchoolHeaderView.stepCountLabel.text = "???"
                    self.mySchoolHeaderView.nextLevelLabel.text = "???"
                    self.mySchoolHeaderView.goalStepCountLabel.text = "???"
                    self.mySchoolHeaderView.rankLabel.text = "???"
                    self.stepCountLabel.text = "???"
                    self.rankLabel.text = "???"
                }
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)

        output.userRankList.bind(to: rankTableView.rx.items(
            cellIdentifier: "rankCell",
            cellType: RankTableViewCell.self)
        ) { _, items, cell in
            print(items)
            cell.imgView.kf.setImage(with: items.profileImageUrl)
            cell.nameLabel.text = items.name
            cell.rankLabel.text = "\(items.ranking)등"
            cell.stepLabel.text = "\(items.walkCount) 걸음"
            self.setRanking(items.ranking, cell.badgeImgView)
        }.disposed(by: disposeBag)

        output.isJoined
            .asObservable()
            .subscribe(onNext: {
                self.joinClassBtn.isHidden = $0
            }).disposed(by: disposeBag)
    }
}

// MARK: - Layout
extension RankViewController {
    private func addSubviews() {
        [rankTableView, myViewBackground, joinClassBtn]
            .forEach { view.addSubview($0) }
        myViewBackground.addSubview(myView)

        [imgView, nameLabel, stepCountLabel, rankLabel, badgeImgView]
            .forEach { myView.addSubview($0) }
    }
    private func makeSubviewConstraints() {
        myViewBackground.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        myView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        imgView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(40)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imgView)
            $0.leading.equalTo(imgView.snp.trailing).offset(16)
        }
        stepCountLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalTo(nameLabel)
            $0.bottom.equalToSuperview().inset(11)
        }
        rankLabel.snp.makeConstraints {
            $0.centerY.equalTo(imgView)
            $0.trailing.equalToSuperview().inset(16)
        }
        badgeImgView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.height.equalTo(27)
            $0.width.equalTo(14)
            $0.trailing.equalTo(rankLabel.snp.leading).inset(11)
        }
        rankTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        joinClassBtn.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
    }
}
extension RankViewController {
    private func setTableView() {
        rankTableView.rx.contentOffset
            .map { $0.y <= 90 }
            .subscribe(onNext: {
                self.myViewBackground.isHidden = $0
            }).disposed(by: disposeBag)

        rankTableView.tableHeaderView = mySchoolHeaderView
        rankTableView.tableFooterView = footerView
    }
}
