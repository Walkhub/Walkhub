import UIKit

import SnapKit
import Then

class RecordMeasurementViewController: UIViewController {

    private let distanceList = ["1km", "2km", "3km", "4km"]
    private let stepCountList = ["5000", "10000", "15000", "20000"]

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
            $0.backgroundColor = .init(named: "FAFAFA")
        }

    private let recordTableView = UITableView().then {
        $0.backgroundColor = .init(named: "FAFAFA")
    }

    private let whiteView = UIView().then {
        $0.backgroundColor = .white
    }

    private let goalLabel = UILabel().then {
        $0.text = "목표"
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }

    private let distancePickerView = UIPickerView()

    private let distanceLabel = UILabel().then {
        $0.text = "거리"
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }

    private let stepCountPickerView = UIPickerView()

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

    override func viewDidAppear(_ animated: Bool) {
        createPickerView()
        dismissPickerView()
    }

    // MARK: AutoLayout Code
    private func setup() {
        [recordLabel, triangle, recordListCollecionView, recordTableView, whiteView].forEach { view.addSubview($0) }

        [goalLabel, distancePickerView, distanceLabel, stepCountPickerView, stepCountLabel, playBtn].forEach { whiteView.addSubview($0) }

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

        distancePickerView.snp.makeConstraints {
            $0.top.equalTo(goalLabel.snp.bottom).offset(13)
            $0.leading.lessThanOrEqualToSuperview().inset(115)
            $0.trailing.equalTo(distanceLabel.snp.leading).offset(-70)
            $0.width.equalTo(100)
            $0.height.equalTo(45)
        }

        distanceLabel.snp.makeConstraints {
            $0.centerY.equalTo(distancePickerView)
            $0.trailing.equalToSuperview().inset(115)
        }

        stepCountPickerView.snp.makeConstraints {
            $0.top.equalTo(distancePickerView.snp.bottom).offset(7)
            $0.leading.lessThanOrEqualToSuperview().inset(115)
            $0.trailing.equalTo(stepCountLabel.snp.leading).offset(-70)
            $0.width.equalTo(100)
            $0.height.equalTo(45)
        }

        stepCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(stepCountPickerView)
            $0.trailing.equalToSuperview().inset(115)
        }

        playBtn.snp.makeConstraints {
            $0.top.equalTo(stepCountPickerView.snp.bottom).offset(28)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(55)
        }
    }
}

extension RecordMeasurementViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    fileprivate func createPickerView() {
        stepCountPickerView.delegate = self
        distancePickerView.delegate = self
    }

    fileprivate func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == distancePickerView {
            return distanceList.count
        } else {
            return stepCountList.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        pickerView.subviews.forEach {
            $0.backgroundColor = .clear
        }

        let label = UILabel().then {
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textColor = .black
            if pickerView == distancePickerView {
                $0.text = "\(distanceList[row])"
            } else {
                $0.text = "\(stepCountList[row])"
            }
        }

        return label
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

    }
}
