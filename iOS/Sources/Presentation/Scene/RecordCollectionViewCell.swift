import UIKit

import SnapKit
import Then

class RecordCollectionViewCell: UICollectionViewCell {

    let imgView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 16
    }

    let dateLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .white
    }

    let locationLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .white
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeSubviewConstraints()
    }
}

extension RecordCollectionViewCell {
    private func addSubviews() {
        self.addSubview(imgView)
        [dateLabel, locationLabel].forEach { imgView.addSubview($0) }
    }

    private func makeSubviewConstraints() {
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
