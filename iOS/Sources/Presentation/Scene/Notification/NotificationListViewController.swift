import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class NotificationListViewController: UIViewController {
    var viewModel: NotificationListViewModel!
    private let date = Date()

    private var disposeBag = DisposeBag()
    private let getData = PublishRelay<Void>()

    private let noNotificationLabel = UILabel().then {
        $0.text = "새로운 알림이 없어요."
        $0.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.textColor = .gray700
    }
    private let notificationListTableView = UITableView().then {
        $0.register(NotificationListTableViewCell.self, forCellReuseIdentifier: "cell")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        view.backgroundColor = .white
        navigationController?.navigationBar.setBackButtonToArrow()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSubviews()
        makeSubviewConstraints()
    }

    private func bind() {
        let input = NotificationListViewModel.Input(getData: getData.asDriver(onErrorJustReturn: ()))

        let output = viewModel.transform(input)

        output.notificationList.bind(to: notificationListTableView.rx.items(
            cellIdentifier: "cell",
            cellType: NotificationListTableViewCell.self
        )) { _, items, cell in
            cell.title.text = items.title
            cell.name.text = items.writer.name
            cell.profileImg.kf.setImage(with: items.writer.profileImageUrl)
            cell.timeLabel.text = self.date.offset(from: items.created)
        }.disposed(by: disposeBag)
    }
}

extension NotificationListViewController {
    private func addSubviews() {
        [noNotificationLabel, notificationListTableView].forEach { view.addSubview($0) }
    }
    private func makeSubviewConstraints() {
        noNotificationLabel.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin).offset(24)
            $0.centerX.equalToSuperview()
        }
        notificationListTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
