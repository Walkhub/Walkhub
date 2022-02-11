// swiftlint:disable line_length
import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class RecordMeasurementViewController: UIViewController {

    private var disposeBag = DisposeBag()
    private var distanceList = Array(0...99)
    private var stepCountList = Array(0...99)

    private let recordLabel = UILabel().then {
        $0.text = "전체 기록"
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let triangle = UIImageView().then {
        $0.image = .init(systemName: "arrowtriangle.right")
        $0.tintColor = .gray600
    }

    private let headerView = RecordHeaderView().then {
        $0.recordListCollecionView.register(RecordCollectionViewCell.self,
                                            forCellWithReuseIdentifier: "locationCell")
        $0.frame.size.height = 220
    }

    private let recordTableView = UITableView().then {
        $0.backgroundColor = .gray50
        $0.separatorStyle = .none
        $0.register(RecordTableViewCell.self, forCellReuseIdentifier: "recordCell")
    }

    private let whiteView = UIView().then {
        $0.backgroundColor = .white
    }

    private let distanceBtn = UIButton(type: .system).then {
        $0.setTitle("거리", for: .normal)
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.setBackgroundColor(.primary400, for: .selected)
        $0.setBackgroundColor(.white, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.setTitleColor(.gray400, for: .normal)
    }

    private let stepCountBtn = UIButton(type: .system).then {
        $0.setTitle("시간", for: .normal)
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.setBackgroundColor(.primary400, for: .selected)
        $0.setBackgroundColor(.white, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.setTitleColor(.gray400, for: .normal)
    }

    private let commaLabel = UILabel().then {
        $0.text = "."
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
    }

    private let distancePickerView = UIPickerView()
    private let stepCountPickerView = UIPickerView()

    private let uintLabel = UILabel().then {
        $0.text = "km"
        $0.font = .notoSansFont(ofSize: 20, family: .regular)
    }

    private let playBtn = UIButton(type: .system).then {
        $0.setImage(.init(systemName: "play.circle.fill"), for: .normal)
        $0.setPreferredSymbolConfiguration(.init(pointSize: 56), forImageIn: .normal)
        $0.tintColor = .primary400
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray50
        self.navigationItem.title = "기록 측정"
        recordTableView.delegate = self
        recordTableView.dataSource = self
        recordTableView.tableHeaderView = headerView
        headerView.recordListCollecionView.delegate = self
        headerView.recordListCollecionView.dataSource = self
        setBtn()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        distanceBtn.isSelected = true
        createPickerView()
        dismissPickerView()
        distancePickerView.selectRow(self.distanceList.count, inComponent: 0, animated: false)
        stepCountPickerView.selectRow(self.stepCountList.count, inComponent: 0, animated: false)
    }

    private func setBtn() {
        distanceBtn.rx.tap.subscribe(onNext: {
            self.distanceBtn.isSelected = true
            self.stepCountBtn.isSelected = false
            self.stepCountList = Array(0...99)
            self.stepCountPickerView.reloadAllComponents()
            self.commaLabel.text = "."
            self.uintLabel.text = "km"
        }).disposed(by: disposeBag)

        stepCountBtn.rx.tap.subscribe(onNext: {
            self.distanceBtn.isSelected = false
            self.stepCountBtn.isSelected = true
            self.stepCountList = Array(0...999)
            self.stepCountPickerView.reloadAllComponents()
            self.commaLabel.text = ","
            self.uintLabel.text = "걸음"
        }).disposed(by: disposeBag)
    }
}

// MARK: - Layout
extension RecordMeasurementViewController {
    private func addSubviews() {
        [recordLabel, triangle,
         recordTableView, whiteView].forEach { view.addSubview($0) }

        [distanceBtn, stepCountBtn, commaLabel,
         distancePickerView, stepCountPickerView, uintLabel, playBtn]
            .forEach { whiteView.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        recordLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
            $0.leading.equalToSuperview().inset(16)
        }

        triangle.snp.makeConstraints {
            $0.leading.equalTo(recordLabel.snp.trailing).offset(6.5)
            $0.centerY.equalTo(recordLabel)
            $0.width.equalTo(13)
            $0.height.equalTo(16)
        }

        recordTableView.snp.makeConstraints {
            $0.top.equalTo(recordLabel.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
        }

        whiteView.snp.makeConstraints {
            $0.height.equalTo(340)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        distanceBtn.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.equalToSuperview().inset(82)
            $0.width.equalTo(80)
            $0.height.equalTo(28)
        }

        stepCountBtn.snp.makeConstraints {
            $0.top.equalTo(distanceBtn)
            $0.trailing.equalToSuperview().inset(82)
            $0.width.equalTo(80)
            $0.height.equalTo(28)
        }

        distancePickerView.snp.makeConstraints {
            $0.top.equalTo(stepCountBtn.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(72)
            $0.width.equalTo(45)
            $0.height.equalTo(126)
        }

        commaLabel.snp.makeConstraints {
            $0.centerY.equalTo(distancePickerView)
            $0.leading.equalTo(distancePickerView.snp.trailing).offset(24)
        }

        stepCountPickerView.snp.makeConstraints {
            $0.top.equalTo(distancePickerView)
            $0.leading.equalTo(commaLabel.snp.trailing).offset(24)
            $0.width.equalTo(50)
            $0.height.equalTo(126)
        }

        uintLabel.snp.makeConstraints {
            $0.centerY.equalTo(distancePickerView)
            $0.trailing.equalToSuperview().inset(72)
        }

        playBtn.snp.makeConstraints {
            $0.top.equalTo(distancePickerView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(56)
        }
    }
}

extension RecordMeasurementViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    fileprivate func createPickerView() {
        stepCountPickerView.delegate = self
        distancePickerView.delegate = self
    }

    fileprivate func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 50
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == distancePickerView {
            return distanceList.count * 2
        } else {
            return stepCountList.count * 2
        }
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 55
    }

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        pickerView.subviews.forEach {
            $0.backgroundColor = .clear
        }

        let label = UILabel().then {
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 24, weight: .bold)
            $0.textColor = .black
            if pickerView  == stepCountPickerView && distanceBtn.isSelected {
                $0.text = String(format: "%02d", stepCountList[row % stepCountList.count])
            } else if pickerView == stepCountPickerView && !distanceBtn.isSelected {
                $0.text = String(format: "%03d", stepCountList[row % stepCountList.count])
            } else {
                $0.text = String(format: "%02d", distanceList[row % distanceList.count])
            }
        }
        return label
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == distancePickerView {
            pickerView.selectRow(distanceList.count + row, inComponent: 0, animated: false)
        } else {
            pickerView.selectRow(stepCountList.count + row, inComponent: 0, animated: false)
        }
    }
}

extension RecordMeasurementViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "locationCell", for: indexPath) as? RecordCollectionViewCell
        cell?.imgView.backgroundColor = .blue
        cell?.dateLabel.text = "2021.12.20"
        cell?.locationLabel.text = "대전 장동"
        return cell!
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 123, height: 195)
        }
}

extension RecordMeasurementViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 8
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as? RecordTableViewCell
        cell?.imgView.image = .init(systemName: "clock.fill")
        cell?.recordName.text = "김시안"
        return cell!
    }
}
