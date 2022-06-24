import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Kingfisher

class ParticipatingViewController: UIViewController {

    var challengeId = Int()
    var viewModel: ParticipatingViewModel!

    private var disposeBag = DisposeBag()
    private let getData = PublishRelay<Int>()

    // MARK: - UI
    private let challengeScrollView = UIScrollView().then {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    private let challengeContentView = UIView()

    private let participateView = UIView().then {
        $0.backgroundColor = .white
        $0.alpha = 0.8
    }
    private let challengeImageView = UIImageView()

    private let challengeTitleLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
        $0.textColor = .gray900
    }
    private let organizerLable = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .medium)
        $0.textColor = .gray800
    }
    private let dateLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
        $0.textColor = .gray700
    }
    private let organizerImageView = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.width / 2
    }
    private let targetDistanceLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
        $0.textColor = .gray800
    }
    private let purposeLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
        $0.textColor = .gray800
    }
    private let presentLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.textColor = .gray800
    }
    private let currentProgressView = UIProgressView().then {
        $0.progressViewStyle = .default
        $0.progressTintColor = .primary400
        $0.trackTintColor = .gray200
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 5
    }
    private let currentPercentageLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }
    private let currentDistanceLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }
    private let challengeTextView = UITextView().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }
    private let stackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
    }
    private let profileImageView = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.width / 2
    }
    private let secondProfileImageView = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.width / 2
    }
    private let thirdProfileImageView = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.width / 2
    }
    private let peopleCountView = UIView().then {
        $0.backgroundColor = .gray500
    }
    private let peopleCountLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
        $0.textColor = .gray800
    }
    private let participantsLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray700
    }
    private let calendarIcon = UIImageView().then {
        $0.image = .init(named: "calendarImg")
    }
    private let flagIcon = UIImageView().then {
        $0.image = .init(named: "flagImg")
    }
    private let rewardIcon = UIImageView().then {
        $0.image = .init(named: "rewardImg")
    }
    private let currentProgressLabel = UILabel().then {
        $0.text = "현재진행도"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray800
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSubviews()
        makeSubviewConstraints()
        peopleCountView.clipsToBounds = true
        organizerImageView.clipsToBounds = true
        profileImageView.clipsToBounds = true
        secondProfileImageView.clipsToBounds = true
        thirdProfileImageView.clipsToBounds = true
        peopleCountView.layer.cornerRadius = peopleCountView.frame.width / 2
        organizerImageView.layer.cornerRadius = organizerImageView.frame.width / 2
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        secondProfileImageView.layer.cornerRadius = secondProfileImageView.frame.width / 2
        thirdProfileImageView.layer.cornerRadius = thirdProfileImageView.frame.width / 2
    }
    override func viewWillAppear(_ animated: Bool) {
        getData.accept(challengeId)
        tabBarController?.tabBar.isHidden = true
        challengeTextView.isEditable = false
        challengeTextView.isScrollEnabled = false
    }

    // MARK: - Bind
    // swiftlint:disable function_body_length
    private func bindViewModel() {
        let input = ParticipatingViewModel.Input(
            getData: getData.asDriver(onErrorJustReturn: 0)
        )
        let output = viewModel.transform(input)

        output.detailChallenge.asObservable()
            .subscribe(onNext: {
                self.challengeTitleLabel.text = $0.name
                print($0.name)
                self.organizerLable.text = $0.name
                self.challengeImageView.kf.setImage(with: $0.imageUrl)
                self.organizerImageView.kf.setImage(with: $0.writer.profileImageUrl)
                print($0.profileImageUrl)
                self.dateLabel.text = "\($0.start.challengeToString()) ~ \($0.end.challengeToString())"
                if $0.goalType == "DISTANCE" {
                    self.targetDistanceLabel.text = "기간 내 \($0.goal)km 달성"
                } else {
                    self.targetDistanceLabel.text = "기간 내 \($0.goal)걸음 달성"
                }
                if $0.goalType == "DISTANCE" {
                    self.presentLabel.text = "\($0.totalValue)km"
                } else {
                    self.presentLabel.text = "\($0.totalValue)걸음"
                }
                if $0.totalValue == 0 {
                    self.currentPercentageLabel.text = "0%"
                } else {
                    self.currentPercentageLabel.text = "\($0.totalValue / $0.goal)%"
                }
                self.purposeLabel.text = $0.award
                if $0.goalType == "DISTANCE" {
                    self.currentDistanceLabel.text = "\($0.goal)km"
                } else {
                    self.currentDistanceLabel.text = "\($0.goal)걸음"
                }
                self.challengeTextView.text = $0.content
                switch $0.participantList.count {
                case 0:
                    self.profileImageView.isHidden = true
                    self.secondProfileImageView.isHidden = true
                    self.thirdProfileImageView.isHidden = true
                    self.peopleCountLabel.isHidden = true
                    self.peopleCountView.isHidden = true
                case 1:
                    self.profileImageView.kf.setImage(with: $0.participantList[0].profileImageUrl)
                    self.secondProfileImageView.isHidden = true
                    self.thirdProfileImageView.isHidden = true
                    self.peopleCountLabel.text = "+0"
                case 2:
                    self.profileImageView.kf.setImage(with: $0.participantList[0].profileImageUrl)
                    self.secondProfileImageView.kf.setImage(with: $0.participantList[1].profileImageUrl)
                    self.thirdProfileImageView.isHidden = true
                    self.peopleCountLabel.text = "+0"
                default:
                    self.profileImageView.kf.setImage(with: $0.participantList[0].profileImageUrl)
                    self.secondProfileImageView.kf.setImage(with: $0.participantList[1].profileImageUrl)
                    self.thirdProfileImageView.kf.setImage(with: $0.participantList[2].profileImageUrl)
                    self.peopleCountLabel.text = "+\($0.participantList.count - 3)"
                }
            }).disposed(by: disposeBag)
    }
}

// MARK: - Layout
extension ParticipatingViewController {

    private func addSubviews() {
        [challengeScrollView, participateView, stackView, peopleCountView]
            .forEach { view.addSubview($0) }
        [thirdProfileImageView, secondProfileImageView, profileImageView]
            .forEach { stackView.addSubview($0) }
        peopleCountView.addSubview(peopleCountLabel)
    challengeScrollView.addSubview(challengeContentView)
        [challengeImageView,
         challengeTitleLabel,
         organizerImageView,
         organizerLable,
         dateLabel,
         targetDistanceLabel,
         purposeLabel,
         calendarIcon,
         flagIcon,
         rewardIcon,
         presentLabel,
         currentProgressView,
         currentPercentageLabel,
         currentDistanceLabel,
         challengeTextView,
         currentProgressLabel
        ].forEach { challengeContentView.addSubview($0) }
    }

    // swiftlint:disable function_body_length
    private func makeSubviewConstraints() {
        challengeScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        challengeContentView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.trailing.leading.equalTo(self.view)
            $0.width.equalTo(challengeScrollView.snp.width)
        }

        challengeImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(1)
            $0.trailing.leading.equalToSuperview().inset(10)
            $0.height.equalTo(240)
        }

        challengeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(challengeImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }

        organizerImageView.snp.makeConstraints {
            $0.top.equalTo(challengeTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
            $0.height.width.equalTo(20)
        }

        organizerLable.snp.makeConstraints {
            $0.top.equalTo(challengeTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(organizerImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(20)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(organizerLable.snp.bottom).offset(16)
            $0.leading.equalTo(calendarIcon.snp.trailing).offset(12)
        }

        targetDistanceLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(8)
            $0.leading.equalTo(flagIcon.snp.trailing).offset(12)
        }

        purposeLabel.snp.makeConstraints {
            $0.top.equalTo(targetDistanceLabel.snp.bottom).offset(8)
            $0.leading.equalTo(rewardIcon.snp.trailing).offset(12)
        }

        calendarIcon.snp.makeConstraints {
            $0.top.equalTo(organizerImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }

        flagIcon.snp.makeConstraints {
            $0.top.equalTo(calendarIcon.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }

        rewardIcon.snp.makeConstraints {
            $0.top.equalTo(flagIcon.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }

        presentLabel.snp.makeConstraints {
            $0.top.equalTo(currentProgressLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }

        currentProgressView.snp.makeConstraints {
            $0.top.equalTo(presentLabel.snp.bottom).offset(9)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(8)
        }

        currentPercentageLabel.snp.makeConstraints {
            $0.top.equalTo(currentProgressView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }

        currentDistanceLabel.snp.makeConstraints {
            $0.top.equalTo(currentProgressView.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(20)
        }

        challengeTextView.snp.makeConstraints {
            $0.top.equalTo(currentProgressView.snp.bottom).offset(30)
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
        }

        participateView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(0)
            $0.trailing.leading.equalToSuperview().inset(0)
            $0.height.equalTo(70)
        }

        stackView.snp.makeConstraints {
            $0.centerY.equalTo(participateView)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(40)
            $0.width.equalTo(164)
        }

        profileImageView.snp.makeConstraints {
            $0.centerY.equalTo(stackView)
            $0.trailing.equalTo(peopleCountView.snp.leading).offset(15)
            $0.width.height.equalTo(40)
        }

        secondProfileImageView.snp.makeConstraints {
            $0.centerY.equalTo(stackView)
            $0.trailing.equalTo(profileImageView.snp.leading).offset(15)
            $0.width.height.equalTo(40)
        }

        thirdProfileImageView.snp.makeConstraints {
            $0.centerY.equalTo(stackView)
            $0.trailing.equalTo(secondProfileImageView.snp.leading).offset(15)
            $0.width.height.equalTo(40)
        }

        peopleCountView.snp.makeConstraints {
            $0.centerY.equalTo(participateView)
            $0.leading.equalToSuperview().inset(88)
            $0.width.height.equalTo(40)
        }

        peopleCountLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }

        currentProgressLabel.snp.makeConstraints {
            $0.top.equalTo(rewardIcon.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }
    }
}
