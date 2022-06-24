import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Kingfisher
import Service

class ChallengeViewController: UIViewController {

    var viewModel: ChallengeViewModel!
    private var disposeBag = DisposeBag()

    private let getData = PublishRelay<Void>()
    private let moveDetailChallenge = PublishRelay<Void>()
    private var challengeList = [Challenge]()
    private var joinedChallengeList = [JoinedChallenge]()
    private let moveDetailedChallenge = PublishRelay<Void>()

    private let challengeTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .gray50
        $0.rowHeight = 134.0
        $0.separatorStyle = .none
        $0.delaysContentTouches = false
        $0.register(ParticipatingChallengeTableViewCell.self, forCellReuseIdentifier: "participatingChallengeCell")
        $0.register(WholeChallengeTableViewCell.self, forCellReuseIdentifier: "wholeChallengeCell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        challengeTableView.dataSource = self
        challengeTableView.delegate = self
        setNavigation()
        bindViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        getData.accept(())
    }
    override func viewDidLayoutSubviews() {
        self.view.addSubview(challengeTableView)

        challengeTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setNavigation() {
        self.navigationItem.title = "챌린지"
    }

    private func bindViewModel() {
        let input = ChallengeViewModel.Input(
            getData: getData.asDriver(onErrorJustReturn: ()),
            cellDidSelect: challengeTableView.rx.itemSelected.asDriver()
        )

        let output = viewModel.transform(input)
        output.challengList.asObservable().subscribe(onNext: {
            print($0)
            self.challengeList = $0
            self.challengeTableView.reloadData()
        }).disposed(by: disposeBag)

        output.joinedChallengeList.asObservable()
            .subscribe(onNext: {
                print($0)
                self.challengeTableView.reloadData()
                self.joinedChallengeList = $0
            }).disposed(by: disposeBag)
    }
}

extension ChallengeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return joinedChallengeList.count
        } else {
            return challengeList.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "participatingChallengeCell",
                for: indexPath
            ) as? ParticipatingChallengeTableViewCell
            cell?.selectionStyle = .none
            cell?.challengeTitleLabel.text = joinedChallengeList[indexPath.row].name
            cell?.organizerLable.text = joinedChallengeList[indexPath.row].writer.name
            cell?.dateLabel.text = "\(joinedChallengeList[indexPath.row].start.challengeToString()) ~ \(joinedChallengeList[indexPath.row].end.challengeToString())"
            cell?.schoolLogoImageView.kf.setImage(with: joinedChallengeList[indexPath.row].writer.profileImageUrl)
            if (joinedChallengeList[indexPath.row].goalType.rawValue == "DISTANCE") {
                cell?.presentStepCountLabel.text = "현재 \(joinedChallengeList[indexPath.row].goal)km"
            } else {
                cell?.presentStepCountLabel.text = "현재 \(joinedChallengeList[indexPath.row].goal)걸음"
            }
            if (joinedChallengeList[indexPath.row].goalType.rawValue == "DISTANCE") {
                cell?.stepCountLabel.text = "\(joinedChallengeList[indexPath.row].goal)km"
            } else {
                cell?.stepCountLabel.text = "\(joinedChallengeList[indexPath.row].goal)걸음"
            }

            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "wholeChallengeCell",
                for: indexPath
            ) as? WholeChallengeTableViewCell
            cell?.challengeTitleLabel.text = challengeList[indexPath.row].name
            cell?.organizerLable.text = challengeList[indexPath.row].writer.name
            cell?.schoolLogoImageView.kf.setImage(with: challengeList[indexPath.row].writer.profileImageUrl)
            switch challengeList[indexPath.row].participantList.count {
            case 0:
                print("아무것도 없음.")
                cell?.profileImageView.isHidden = true
                cell?.secondProfileImageView.isHidden = true
                cell?.thirdProfileImageView.isHidden = true
                cell?.participantsLabel.isHidden = true
            case 1:
                cell?.profileImageView.kf.setImage(with: challengeList[indexPath.row].participantList[0].profileImageUrl)
                cell?.secondProfileImageView.isHidden = true
                cell?.thirdProfileImageView.isHidden = true
                cell?.participantsLabel.text = "+0"
            case 2:
                cell?.profileImageView.kf.setImage(with: challengeList[indexPath.row].participantList[0].profileImageUrl)
                cell?.secondProfileImageView.kf.setImage(with: challengeList[indexPath.row].participantList[1].profileImageUrl)
                cell?.thirdProfileImageView.isHidden = true
                cell?.participantsLabel.text = "+0"
            default:
                cell?.profileImageView.kf.setImage(with: challengeList[indexPath.row].participantList[0].profileImageUrl)
                cell?.secondProfileImageView.kf.setImage(with: challengeList[indexPath.row].participantList[1].profileImageUrl)
                cell?.thirdProfileImageView.kf.setImage(with: challengeList[indexPath.row].participantList[2].profileImageUrl)
                cell?.participantsLabel.text = "+\(challengeList[indexPath.row].participantList.count - 3)"
            }
            cell?.dateLabel.text = "\(challengeList[indexPath.row].start.challengeToString()) ~ \(challengeList[indexPath.row].end.challengeToString())"
            if challengeList[indexPath.row].goalScope.rawValue == "DAY" {
                if challengeList[indexPath.row].goalType.rawValue == "DISTANCE" {
                    cell?.targetDistanceLabel.text = "하루 한 번 \(challengeList[indexPath.row].goal)km 달성"
                } else {
                    cell?.targetDistanceLabel.text = "하루 한 번 \(challengeList[indexPath.row].goal)걸음 달성"
                }
            } else {
                if challengeList[indexPath.row].goalType.rawValue == "DISTANCE" {
                    cell?.targetDistanceLabel.text = "기간 내 \(challengeList[indexPath.row].goal)km 달성"
                } else {
                    cell?.targetDistanceLabel.text = "기간 내 \(challengeList[indexPath.row].goal)걸음 달성"
                }
            }
            return cell!
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "참여 중인 챌린지"
        } else {
            return "전체 챌린지"
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            moveDetailedChallenge.accept(())
        } else {
            moveDetailedChallenge.accept(())
        }
    }
}
