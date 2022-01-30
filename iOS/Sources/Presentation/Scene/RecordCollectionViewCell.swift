import UIKit

import SnapKit
import Then

class RecordCollectionViewCell: UICollectionViewCell {

    private let imgView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 16
    }

    private let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .white
    }

    private let locationLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .white
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        self.addSubview(imgView)
        [dateLabel, locationLabel].forEach { imgView.addSubview($0) }

        imgView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(123)
        }

        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(14)
            $0.bottom.equalTo(locationLabel.snp.top)
        }

        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.leading)
            $0.bottom.equalToSuperview().inset(14)
        }
    }
}
