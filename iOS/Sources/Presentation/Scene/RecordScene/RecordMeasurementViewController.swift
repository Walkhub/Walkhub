// swiftlint:disable line_length
import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Service

class RecordMeasurementViewController: UIViewController {

    var viewModel: RecordMeasurementViewModel!
    private var disposeBag = DisposeBag()
    private var integerNumList = Array(0...99)
    private var underDecimalPointNumList = Array(0...99)
    private let getData = PublishRelay<Void>()
    private let goal = PublishRelay<Int>()
    private let goalType = PublishRelay<ExerciseGoalType>()

    private var selectedFirstNum = 0
    private var selectedSecondNum = 0

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

    private let distanceBtn = UIButton().then {
        $0.setTitle("거리", for: .normal)
        $0.layer.cornerRadius = 15
        $0.layer.masksToBounds = true
        $0.setBackgroundColor(.primary400, for: .selected)
        $0.setBackgroundColor(.white, for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.setTitleColor(.gray400, for: .normal)
    }

    private let stepCountBtn = UIButton().then {
        $0.setTitle("걸음수", for: .normal)
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

    private let integerNumPickerView = UIPickerView()
    private let underDecimalPointNumPickerView = UIPickerView()

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
        recordTableView.tableHeaderView = headerView
        headerView.recordListCollecionView.delegate = self
        bindViewModel()
        setPickerView()
        setBtn()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        distanceBtn.isSelected = true
        integerNumPickerView.selectRow(self.integerNumList.count, inComponent: 0, animated: false)
        integerNumPickerView.selectRow(self.underDecimalPointNumList.count, inComponent: 1, animated: false)
        goalType.accept(.distance)
    }

    private func setBtn() {
        distanceBtn.rx.tap.subscribe(onNext: {
            self.distanceBtn.isSelected = true
            self.stepCountBtn.isSelected = false
            self.underDecimalPointNumList = Array(0...99)
            self.integerNumPickerView.reloadAllComponents()
            self.commaLabel.text = "."
            self.uintLabel.text = "km"
            self.goalType.accept(.distance)
        }).disposed(by: disposeBag)

        stepCountBtn.rx.tap.subscribe(onNext: {
            self.distanceBtn.isSelected = false
            self.stepCountBtn.isSelected = true
            self.underDecimalPointNumList = Array(0...999)
            self.integerNumPickerView.reloadAllComponents()
            self.commaLabel.text = ","
            self.uintLabel.text = "걸음"
            self.goalType.accept(.walkCount)
        }).disposed(by: disposeBag)
    }

    private func bindViewModel() {
        let input = RecordMeasurementViewModel.Input(
            getData: getData.asDriver(onErrorJustReturn: ()),
            goal: goal.asDriver(onErrorJustReturn: 10000),
            goalType: goalType.asDriver(onErrorJustReturn: .distance),
            start: playBtn.rx.tap.asDriver())

        let output = viewModel.transform(input)

        output.exercisesList.bind(to: headerView.recordListCollecionView.rx.items(
            cellIdentifier: "locationCell",
            cellType: RecordCollectionViewCell.self)) {_, items, cell in
                cell.imgView.image = items.imageUrl.toImage()
                cell.dateLabel.text = items.startAt.toString(dateFormat: "yyyy.MM.dd")
            }.disposed(by: disposeBag)
    }
}

// MARK: - Layout
// swiftlint:disable function_body_length
extension RecordMeasurementViewController {
    private func addSubviews() {
        [recordLabel, triangle,
         recordTableView, whiteView].forEach { view.addSubview($0) }

        [distanceBtn, stepCountBtn, commaLabel,
         integerNumPickerView, uintLabel, playBtn]
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

        integerNumPickerView.snp.makeConstraints {
            $0.top.equalTo(stepCountBtn.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview().inset(60)
            $0.height.equalTo(140)
        }

        commaLabel.snp.makeConstraints {
            $0.center.equalTo(integerNumPickerView)
        }

        uintLabel.snp.makeConstraints {
            $0.centerY.equalTo(integerNumPickerView)
            $0.trailing.equalToSuperview().inset(72)
        }

        playBtn.snp.makeConstraints {
            $0.top.equalTo(integerNumPickerView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(56)
        }
    }
}

extension RecordMeasurementViewController: UIPickerViewDataSource, UIPickerViewDelegate {

    fileprivate func setPickerView() {
        integerNumPickerView.dataSource = self
        underDecimalPointNumPickerView.dataSource = self
        integerNumPickerView.delegate = self
        underDecimalPointNumPickerView.delegate = self
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return integerNumList.count * 2
        case 1:
            return underDecimalPointNumList.count * 2
        default:
            return 0
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
            if component  == 1 && distanceBtn.isSelected {
                $0.text = String(format: "%02d", underDecimalPointNumList[row % underDecimalPointNumList.count])
            } else if component == 1 && !distanceBtn.isSelected {
                $0.text = String(format: "%03d", underDecimalPointNumList[row % underDecimalPointNumList.count])
            } else {
                $0.text = String(format: "%02d", integerNumList[row % integerNumList.count])
            }
        }
        return label
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedFirstNum = integerNumList[row%100]
        case 1:
            if distanceBtn.isSelected == true {
                selectedSecondNum = underDecimalPointNumList[row%100]
            } else {
                selectedSecondNum = underDecimalPointNumList[row%1000]
            }
        default:
            break
        }

        if distanceBtn.isSelected == true {
            goal.accept(Int((Float(selectedFirstNum) + Float(selectedSecondNum)/100) * 1000))
        } else {
            goal.accept((selectedFirstNum*1000) + selectedSecondNum)
        }
    }
}

extension RecordMeasurementViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 123, height: 195)
        }
}

extension RecordMeasurementViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 8
    }
}
