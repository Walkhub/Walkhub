import UIKit

import SnapKit
import Then

class RecordMeasurementViewController: UIViewController {

// MARK: Screen Object Code
    private let recordLabel = UILabel().then {
        $0.text = "전체 기록"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private let triangle = UIImageView().then {
        $0.image = .init(systemName: "arrowtriangle.right")
        $0.tintColor = .init(named: "707070")
    }

    private let recordListCollecionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.minimumInteritemSpacing = 12
            $0.scrollDirection = .horizontal
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }).then {
            $0.backgroundColor = .white
        }

    private let recordTableView = UITableView().then {
        $0.backgroundColor = .white
    }

    private let whiteView = UIView().then {
        $0.backgroundColor = .white
    }

    private let goalLabel = UILabel().then {
        $0.text = "목표"
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    private let distance = UITextField().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private let distanceLabel = UILabel().then {
        $0.text = "거리"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private let stepCount = UITextField().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private let stepCountLabel = UILabel().then {
        $0.text = "걸음"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private let playBtn = UIButton(type: .system).then {
        $0.setImage(.init(systemName: "play.circle"), for: .normal)
        $0.tintColor = .init(named: "57B4F1")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(named: "FAFAFA")
        self.navigationItem.title = "기록 측정"
    }

    override func viewDidLayoutSubviews() {
        setup()
    }

// MARK: AutoLayout Code
    private func setup() {
        [recordLabel, triangle, recordListCollecionView, recordTableView, whiteView].forEach { view.addSubview($0) }

        [goalLabel, distance, distanceLabel, stepCount, stepCountLabel, playBtn].forEach { whiteView.addSubview($0) }

        recordLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
            $0.leading.equalToSuperview().inset(16)
        }

        triangle.snp.makeConstraints {
            $0.leading.equalTo(recordLabel.snp.trailing).offset(6.5)
            $0.centerY.equalTo(recordLabel)
            $0.width.equalTo(16)
            $0.height.equalTo(13)
        }

        recordListCollecionView.snp.makeConstraints {
            $0.top.equalTo(recordLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(195)
        }

        recordTableView.snp.makeConstraints {
            $0.top.equalTo(recordListCollecionView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(66)
        }

        whiteView.snp.makeConstraints {
            $0.top.equalTo(recordTableView.snp.bottom).offset(35)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        goalLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.centerX.equalToSuperview()
        }

        distance.snp.makeConstraints {
            $0.top.equalTo(goalLabel.snp.bottom).offset(13)
            $0.leading.equalToSuperview().inset(115)
        }

        distanceLabel.snp.makeConstraints {
            $0.top.equalTo(distance.snp.top)
            $0.trailing.equalToSuperview().inset(115)
        }

        stepCount.snp.makeConstraints {
            $0.top.equalTo(distance.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(115)
        }

        stepCountLabel.snp.makeConstraints {
            $0.top.equalTo(stepCount.snp.top)
            $0.trailing.equalToSuperview().inset(115)
        }

        playBtn.snp.makeConstraints {
            $0.top.equalTo(stepCount.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(55)
        }
    }
}
