import UIKit

import SnapKit
import Then

class RecordHeaderView: UIView {
    let recordListCollecionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.minimumInteritemSpacing = 12
            $0.scrollDirection = .horizontal
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }).then {
            $0.backgroundColor = .gray50
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeSubviewConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension RecordHeaderView {
    private func addSubviews() {
        self.addSubview(recordListCollecionView)
    }

    private func makeSubviewConstraints() {
        recordListCollecionView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
