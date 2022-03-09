import UIKit

import RxSwift
import RxCocoa
import Service

class RankPreviewTableViewCell: UITableViewCell {

    private var disposeBag = DisposeBag()

    let rankTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.register(RankTableViewCell.self, forCellReuseIdentifier: "rankCell")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(rankTableView)
        rankTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    internal func setup(userList: PublishRelay<[RankedUser]>) {
        userList.bind(
            to: rankTableView.rx.items(
            cellIdentifier: "rankCell",
            cellType: RankTableViewCell.self
        )) { _, items, cell in
            cell.imgView.kf.setImage(with: items.profileImageUrl)
            cell.nameLabel.text = items.name
            cell.stepLabel.text = "\(items.walkCount) 걸음"
            cell.rankLabel.text = "\(items.ranking)등"
        }.disposed(by: disposeBag)
    }
}
