import UIKit

class RankPreviewTableViewCell: UITableViewCell {

    let rankTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.register(RankTableViewCell.self, forCellReuseIdentifier: "cell")
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

}
