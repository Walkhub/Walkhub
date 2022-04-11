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
    }

    private func setNavigation() {
        self.navigationItem.title = "챌린지"
    }

    override func viewDidLayoutSubviews() {
        self.view.addSubview(challengeTableView)

        challengeTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func bindViewModel() {
        let input = ChallengeViewModel.Input(
            getData: getData.asDriver(onErrorJustReturn: ())
        )

        let output = viewModel.transform(input)

        output.challengList.asObservable().subscribe(onNext: {
            self.challengeList = $0
            self.challengeTableView.reloadData()
        }).disposed(by: disposeBag)
    }
}
extension ChallengeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "participatingChallengeCell", for: indexPath) as? ParticipatingChallengeTableViewCell
            return cell!

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "wholeChallengeCell", for: indexPath) as? WholeChallengeTableViewCell
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
