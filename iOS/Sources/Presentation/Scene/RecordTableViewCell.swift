import UIKit

import SnapKit
import Then

class RecordTableViewCell: UITableViewCell {

    private let view = UIView().then {
        $0.layer.cornerRadius = 13
        $0.backgroundColor = .init(named: "57B4F1")
    }

    private let nameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private let distanceTimeLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private let cheerUpLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private let cheerUpBtn = UIButton(type: .system).then {
        $0.setImage(.init(systemName: "square"), for: .normal)
        $0.tintColor = .black
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setup() {
        self.addSubview(view)
        [nameLabel, distanceTimeLabel, cheerUpLabel, cheerUpBtn].forEach { view.addSubview($0) }

        view.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
            $0.height.equalTo(66)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(24)
        }

        distanceTimeLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalTo(nameLabel.snp.leading)
        }

        cheerUpLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(cheerUpBtn.snp.leading).inset(7)
        }

        cheerUpBtn.snp.makeConstraints {
            $0.centerY.equalTo(cheerUpLabel)
            $0.width.height.equalTo(20)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}

