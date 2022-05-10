import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Service

class ChallengeViewController: UIViewController {

    var viewModel: ChallengeViewModel!
    private var disposeBag = DisposeBag()

    private let getData = PublishRelay<Void>()
    private var challengeList = [Challenge]()
    private var joinedChallengeList = [JoinedChallenge]()

    private let challengeTableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.backgroundColor = .gray50
        $0.register(ParticipatingChallengeTableViewCell.self, forCellReuseIdentifier: "participatingChallengeCell")
        $0.register(WholeChallengeTableViewCell.self, forCellReuseIdentifier: "wholeChallengeCell")
    }

    private let emptyView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        challengeTableView.dataSource = self
        challengeTableView.delegate = self
        setNavigation()
        bindViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
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
            getData: getData.asDriver(onErrorJustReturn: ())
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
                self.joinedChallengeList = $0
            }).disposed(by: disposeBag)
    }
}

extension ChallengeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challengeList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "participatingChallengeCell",
                for: indexPath
            ) as? ParticipatingChallengeTableViewCell
            cell?.challengeTitleLabel.text = joinedChallengeList[indexPath.row].name
            cell?.organizerLable.text = joinedChallengeList[indexPath.row].writer.name
            cell?.dateLabel.text = "\(joinedChallengeList[indexPath.row].start) ~ \(joinedChallengeList[indexPath.row].end)"
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
            cell?.dateLabel.text = "\(challengeList[indexPath.row].start) ~ \(challengeList[indexPath.row].end)"
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
}
