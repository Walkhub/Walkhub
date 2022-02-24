import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Service

class RankViewController: UIViewController {

    private var disposeBag = DisposeBag()

    internal let scope = PublishRelay<GroupScope>()
    internal let dateType = PublishRelay<DateType>()
    internal let myRank = PublishRelay<(User, Int?)>()
    internal let userList = PublishRelay<[User]>()
    internal let defaultUserList = PublishRelay<[DefaultSchoolUserRank]>()
    internal let isMySchool = PublishRelay<Bool>()

    private let mySchoolHeaderView = RankHeaderView().then {
        $0.layer.frame.size.height = 180
    }

    private let anotherSchoolHeaderView = AnotherSchoolRankHeaderView().then {
        $0.layer.frame.size.height = 48
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
        $0.register(CheerupTableViewCell.self, forCellReuseIdentifier: "cheerCell")
    }

    private let joinClassBtn = UIButton(type: .system).then {
        $0.setTitle("반 등록하고 랭킹 확인하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 12
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray50
        setTableView()
        bindViewModel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSubviews()
        makeSubviewConstraints()
        setDropDownAndSwitch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        joinClassBtn.isHidden = true
        setTableView()
    }

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

        anotherSchoolHeaderView.dropDownBtn.dropDown.selectionAction = { row, item in
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

        mySchoolHeaderView.switches.rx.isOn.subscribe(onNext: {
            if $0 {
                self.scope.accept(.class)
            } else {
                self.scope.accept(.school)
            }
        }).disposed(by: disposeBag)
    }

    private func bindViewModel() {
        myRank.asObservable().subscribe(onNext: { rank, num in
            self.mySchoolHeaderView.imgView.image = rank.profileImageUrl.toImage()
            self.mySchoolHeaderView.nameLabel.text = rank.name
            self.mySchoolHeaderView.stepCountLabel.text = "\(rank.walkCount) 걸음"
            self.mySchoolHeaderView.rankLabel.text = "\(rank.ranking)등"
            if rank.ranking != 1 {
                self.mySchoolHeaderView.nextLevelLabel.text = "다음 등수까지 \(num ?? 0 - rank.walkCount) 걸음"
                self.mySchoolHeaderView.goalStepCountLabel.text = "\(num ?? 0) 걸음"
                self.mySchoolHeaderView.progressBar.progress = Float(rank.walkCount / num! )
            } else {
                self.mySchoolHeaderView.nextLevelLabel.text = "최고 등수를 달성했어요!"
                self.mySchoolHeaderView.goalStepCountLabel.text = "\(rank.walkCount) 걸음"
                self.mySchoolHeaderView.progressBar.progress = 1
            }
            self.imgView.image = rank.profileImageUrl.toImage()
            self.nameLabel.text = rank.name
            self.stepCountLabel.text = "\(rank.walkCount) 걸음"
            self.rankLabel.text = "\(rank.ranking)등"
            switch rank.ranking {
            case 1:
                self.mySchoolHeaderView.badgeImgView.image = .init(named: "GoldBadgeImg")
                self.badgeImgView.image = .init(named: "GoldBadgeImg")
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
        }).disposed(by: disposeBag)

        userList.bind(to: rankTableView.rx.items(
            cellIdentifier: "rankCell",
            cellType: RankTableViewCell.self)
        ) { _, items, cell in
            cell.imgView.image = items.profileImageUrl.toImage()
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

        isMySchool.asObservable().subscribe(onNext: {
            if $0 {
                self.rankTableView.tableHeaderView = self.mySchoolHeaderView
            } else {
                self.rankTableView.tableHeaderView = self.anotherSchoolHeaderView
            }
        }).disposed(by: disposeBag)

        rankTableView.tableFooterView = footerView
    }
}
