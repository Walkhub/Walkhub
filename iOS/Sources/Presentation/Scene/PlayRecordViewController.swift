import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class PlayRecordViewController: UIViewController {

    private var disposeBag = DisposeBag()

    private let cheerUpImg = UIImageView().then {
        $0.image = .init(named: "CheerUpImg")
        $0.contentMode = .scaleAspectFit
    }

    private let cheerCommentLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let whiteView = UIView().then {
        $0.backgroundColor = .white
    }

    private let reaminDistanceLabel = UILabel().then {
        $0.text = "남은 거리"
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let currentLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let goalLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let progressBackView = UIView().then {
        $0.backgroundColor = .gray300
        $0.layer.cornerRadius = 8
    }

    private let progressBar = UIProgressView().then {
        $0.progressViewStyle = .default
        $0.trackTintColor = .gray300
        $0.progressTintColor = .primary400
    }

    private let line1 = UIView().then {
        $0.backgroundColor = .gray200
    }

    private let line2 = UIView().then {
        $0.backgroundColor = .gray200
    }

    private let stepCountLabel = UILabel().then {
        $0.text = "걸음수"
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let stepCountNumLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let kcalLabel = UILabel().then {
        $0.text = "걸음수"
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let kcalNumLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let kcalUnitLabel = UILabel().then {
        $0.text = "Kcal"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let speedLabel = UILabel().then {
        $0.text = "속도"
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let speedNumLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let speedUnitLabel = UILabel().then {
        $0.text = "m/s"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let timeLabel = UILabel().then {
        $0.text = "시간"
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
    }

    private let hourLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let hLabel = UILabel().then {
        $0.text = "h"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let minuteLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let mLabel = UILabel().then {
        $0.text = "m"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let stopBtn = UIButton(type: .system).then {
        $0.setBackgroundColor(.primary400, for: .normal)
        $0.tintColor = .white
        $0.setImage(.init(systemName: "pause"), for: .normal)
        $0.setImage(.init(systemName: "lock.fill"), for: .selected)
    }

    private let lockBtn = UIButton(type: .system).then {
        $0.backgroundColor = .gray400
        $0.setImage(.init(systemName: "lock.open.fill"), for: .normal)
        $0.tintColor = .white
    }

    private let blackView = UIView().then {
        $0.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
    }

    private let stopCommentLabel = UILabel().then {
        $0.text = "일시정지 됨"
        $0.textColor = .white
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
    }

    private let replayBtn = UIButton(type: .system).then {
        $0.setImage(.init(systemName: "play.fill"), for: .normal)
        $0.tintColor = .white
        $0.setBackgroundColor(.primary400, for: .normal)
    }

    private let initializationBtn = UIButton(type: .system).then {
        $0.setImage(.init(systemName: "square.fill"), for: .normal)
        $0.setBackgroundColor(.gray400, for: .normal)
        $0.tintColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray50
        navigationItem.title = "기록측정"
        [blackView, stopCommentLabel, replayBtn, initializationBtn]
            .forEach { $0.isHidden = true }
        demoData()
        setBtn()
    }

    override func viewDidLayoutSubviews() {
        addsubViews()
        makeSubviewConstraints()
        setLayoutRound()
    }

    private func setBtn() {
        lockBtn.rx.tap.subscribe(onNext: {
            self.stopBtn.isSelected = true
            self.lockBtn.isHidden = true
        }).disposed(by: disposeBag)

        stopBtn.rx.tap.subscribe(onNext: {
            if self.stopBtn.isSelected {
                self.stopBtn.isSelected = false
                self.lockBtn.isHidden = false
            } else {
                [self.blackView, self.stopCommentLabel, self.replayBtn, self.initializationBtn]
                    .forEach { $0.isHidden = false }
                self.stopBtn.isHidden = true
                self.lockBtn.isHidden = true
            }
        }).disposed(by: disposeBag)

        replayBtn.rx.tap.subscribe(onNext: {
            [self.blackView, self.stopCommentLabel, self.replayBtn, self.initializationBtn]
                .forEach { $0.isHidden = true }
            self.stopBtn.isHidden = false
            self.lockBtn.isHidden = false
        }).disposed(by: disposeBag)
    }

    private func demoData() {
        cheerCommentLabel.text = "김기영님이 응원하셨어요!"
        currentLabel.text = "2.5km"
        goalLabel.text = "/7km"
        progressBar.progress = 0.5
        stepCountNumLabel.text = "3299"
        kcalNumLabel.text = "234"
        speedNumLabel.text = "0.3"
        hourLabel.text = "12"
        minuteLabel.text = "30"
    }

    private func setLayoutRound() {
        stopBtn.layer.cornerRadius = stopBtn.frame.width / 2
        lockBtn.layer.cornerRadius = lockBtn.frame.width / 2
        replayBtn.layer.cornerRadius = replayBtn.frame.width / 2
        initializationBtn.layer.cornerRadius = initializationBtn.frame.width / 2
        stopBtn.clipsToBounds = true
        initializationBtn.clipsToBounds = true
        replayBtn.clipsToBounds = true
    }
}

// MARK: - Layout
extension PlayRecordViewController {
    private func addsubViews() {
        [cheerUpImg, cheerCommentLabel, whiteView, blackView, stopCommentLabel]
            .forEach { view.addSubview($0) }

        [reaminDistanceLabel, currentLabel, goalLabel, progressBackView, progressBar,
        stepCountLabel, stepCountNumLabel, kcalLabel, kcalNumLabel, kcalUnitLabel,
         speedLabel, speedNumLabel, speedUnitLabel, line1, line2, timeLabel, hourLabel,
         hLabel, minuteLabel, mLabel, stopBtn, lockBtn, replayBtn, initializationBtn]
            .forEach{ whiteView.addSubview($0)}
    }

    private func makeSubviewConstraints() {
        cheerUpImg.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(130)
        }

        cheerCommentLabel.snp.makeConstraints {
            $0.top.equalTo(cheerUpImg.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }

        whiteView.snp.makeConstraints {
            $0.top.equalTo(cheerCommentLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        reaminDistanceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(33)
            $0.leading.equalToSuperview().inset(39)
        }

        currentLabel.snp.makeConstraints {
            $0.top.equalTo(reaminDistanceLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(39)
        }

        goalLabel.snp.makeConstraints {
            $0.bottom.equalTo(currentLabel)
            $0.leading.equalTo(currentLabel.snp.trailing).offset(4)
        }

        progressBackView.snp.makeConstraints {
            $0.top.equalTo(goalLabel.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview().inset(39)
            $0.height.equalTo(11)
        }

        progressBar.snp.makeConstraints {
            $0.centerY.equalTo(progressBackView)
            $0.height.equalTo(5)
            $0.leading.trailing.equalTo(progressBackView).inset(3)
        }

        line1.snp.makeConstraints {
            $0.top.equalTo(progressBackView.snp.bottom).offset(56)
            $0.width.equalTo(1)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(28)
        }

        stepCountLabel.snp.makeConstraints {
            $0.top.equalTo(progressBackView.snp.bottom).offset(38)
            $0.trailing.equalTo(line1.snp.leading).offset(-62)
        }

        stepCountNumLabel.snp.makeConstraints {
            $0.top.equalTo(stepCountLabel.snp.bottom).offset(4)
            $0.centerX.equalTo(stepCountLabel)
        }

        kcalLabel.snp.makeConstraints {
            $0.top.equalTo(progressBackView.snp.bottom).offset(38)
            $0.leading.equalTo(line1.snp.trailing).offset(62)
        }

        kcalNumLabel.snp.makeConstraints {
            $0.top.equalTo(kcalLabel.snp.bottom).offset(4)
            $0.leading.equalTo(line1.snp.trailing).offset(49)
        }

        kcalUnitLabel.snp.makeConstraints {
            $0.bottom.equalTo(kcalNumLabel)
            $0.leading.equalTo(kcalNumLabel.snp.trailing).offset(4)
        }

        line2.snp.makeConstraints {
            $0.top.equalTo(line1.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(28)
        }

        speedLabel.snp.makeConstraints {
            $0.top.equalTo(stepCountNumLabel.snp.bottom).offset(27)
            $0.trailing.equalTo(line2.snp.leading).offset(-68)
        }

        speedNumLabel.snp.makeConstraints {
            $0.top.equalTo(speedLabel.snp.bottom).offset(4)
            $0.trailing.equalTo(speedUnitLabel.snp.leading).offset(-4)
        }

        speedUnitLabel.snp.makeConstraints {
            $0.bottom.equalTo(speedNumLabel)
            $0.trailing.equalTo(line2.snp.leading).offset(-48)
        }

        timeLabel.snp.makeConstraints {
            $0.top.equalTo(kcalNumLabel.snp.bottom).offset(27)
            $0.leading.equalTo(line2.snp.trailing).offset(68)
        }

        hourLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
            $0.leading.equalTo(line2.snp.trailing).offset(51)
        }

        hLabel.snp.makeConstraints {
            $0.bottom.equalTo(hourLabel)
            $0.leading.equalTo(hourLabel.snp.trailing).offset(2)
        }

        minuteLabel.snp.makeConstraints {
            $0.top.equalTo(hourLabel)
            $0.leading.equalTo(hLabel.snp.trailing).offset(4)
        }

        mLabel.snp.makeConstraints {
            $0.bottom.equalTo(minuteLabel)
            $0.leading.equalTo(minuteLabel.snp.trailing).offset(2)
        }

        stopBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(77)
            $0.bottom.equalToSuperview().inset(40)
        }

        lockBtn.snp.makeConstraints {
            $0.centerY.equalTo(stopBtn)
            $0.leading.equalTo(stopBtn.snp.trailing).offset(30)
            $0.height.width.equalTo(46)
        }

        blackView.snp.makeConstraints {
            $0.top.equalTo(whiteView.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(hourLabel.snp.bottom).offset(23)
        }

        stopCommentLabel.snp.makeConstraints {
            $0.center.equalTo(blackView)
        }

        replayBtn.snp.makeConstraints {
            $0.top.equalTo(blackView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().inset(93)
            $0.width.height.equalTo(55)
        }

        initializationBtn.snp.makeConstraints {
            $0.top.equalTo(replayBtn.snp.top)
            $0.leading.greaterThanOrEqualTo(replayBtn.snp.trailing).offset(65)
            $0.trailing.equalToSuperview().inset(93)
            $0.width.height.equalTo(55)
        }
    }
}
