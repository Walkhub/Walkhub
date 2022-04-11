import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class DetailedChallengeViewController: UIViewController {

    var viewModel: DetailedChallengeViewModel!

    private let challengeId = PublishRelay<Int>()
    private var disposeBag = DisposeBag()

    private let challengeScrollView = UIScrollView().then {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private let challengeContentView = UIView()

    private let participateView = UIView().then {
        $0.backgroundColor = .white
        $0.alpha = 0.8
    }

    private let challengeImageView = UIImageView().then {
        $0.image = .init(systemName: "photo.artframe")
        $0.tintColor = .gray800
    }

    private let challengeTitleLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 20, family: .medium)
        $0.textColor = .gray900
    }

    private let organizerLable = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .medium)
        $0.textColor = .gray800
    }

    private let schoolLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray800
    }

    private let dateLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
        $0.textColor = .gray700
    }

    private let organizerImageView = UIImageView().then {
        $0.image = .init(systemName: "circle.fill")
        $0.tintColor = .gray800
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    private let challengePeriod = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray800
    }

    private let challengeGoal = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray800
    }

    private let challengeRewards = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray800
    }

    private let targetDistanceLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
        $0.textColor = .gray800
    }

//    private let stepCountLabel = UILabel().then {
//        $0.font = .notoSansFont(ofSize: 12, family: .regular)
//        $0.textColor = .gray800
//    }

    private let purposeLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .medium)
        $0.textColor = .gray800
    }

    private let currentProgressLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
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
        $0.progress = 0.5
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

    private let profileImageView = UIImageView().then {
        $0.tintColor = .gray800
        $0.image = .init(systemName: "circle.fill")
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    private let secondProfileImageView = UIImageView().then {
        $0.tintColor = .gray600
        $0.image = .init(systemName: "circle.fill")
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    private let thirdProfileImageView = UIImageView().then {
        $0.tintColor = .gray400
        $0.image = .init(systemName: "circle.fill")
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

    private let participateBtn = UIButton(type: .system).then {
        $0.setTitle("참여하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .primary400
        $0.layer.cornerRadius = 10
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        demoData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSubviews()
        makeSubviewConstraints()
        peopleCountView.clipsToBounds = true
        peopleCountView.layer.cornerRadius = peopleCountView.frame.width / 2
    }

    func demoData() {
        challengeTitleLabel.text = "2학년 체육 수행평가"
        schoolLabel.text = "대덕소프트웨어마이스터고등학교"
        organizerLable.text = "서무성"
        dateLabel.text = "2022/03/02 ~ 2022/03/31"
        challengePeriod.text = "챌린지 기간"
        challengeGoal.text = "챌린지 목표"
        challengeRewards.text = "챌린지 보상"
        targetDistanceLabel.text = "기간 내 20km 달성"
        purposeLabel.text = "체육 수행평가 성적"
        currentProgressLabel.text = "현재 진행도"
        presentLabel.text = "0km"
        currentPercentageLabel.text = "0%"
        currentDistanceLabel.text = "20km"
        challengeTextView.text = """
대덕소프트웨어마이스터고등학교 2학년 체육 수행평가입니다. 평가 계획 공지사항에 올려놓았으니 알아서 찾아보세요.
대덕소프트웨어마이스터고등학교 2학년 체육 수행평가입니다. 평가 계획 공지사항에 올려놓았으니 알아서 찾아보세요.
대덕소프트웨어마이스터고등학교 2학년 체육 수행평가입니다. 평가 계획 공지사항에 올려놓았으니 알아서 찾아보세요.
대덕소프트웨어마이스터고등학교 2학년 체육 수행평가입니다. 평가 계획 공지사항에 올려놓았으니 알아서 찾아보세요.
대덕소프트웨어마이스터고등학교 2학년 체육 수행평가입니다. 평가 계획 공지사항에 올려놓았으니 알아서 찾아보세요.
대덕소프트웨어마이스터고등학교 2학년 체육 수행평가입니다. 평가 계획 공지사항에 올려놓았으니 알아서 찾아보세요.
대덕소프트웨어마이스터고등학교 2학년 체육 수행평가입니다. 평가 계획 공지사항에 올려놓았으니 알아서 찾아보세요.
대덕소프트웨어마이스터고등학교 2학년 체육 수행평가입니다. 평가 계획 공지사항에 올려놓았으니 알아서 찾아보세요.
"""
        participantsLabel.text = "최민준,김수완,수준호 외 21명 참여 중입니다."
        peopleCountLabel.text = "+21"
    }

    override func viewWillAppear(_ animated: Bool) {
        challengeTextView.isEditable = false
        challengeTextView.isScrollEnabled = false
    }

    private func bindViewModel() {
        let input = DetailedChallengeViewModel.Input(
            challengeId: challengeId.asDriver(onErrorJustReturn: 0),
            joinButtonDidTap: participateBtn.rx.tap.asDriver())

        let output = viewModel.transform(input)

        output.detailChallenge.asObservable()
            .subscribe(onNext: {
                self.challengeTitleLabel.text = $0.name
                self.organizerLable.text = $0.name
                self.dateLabel.text = "\($0.start.challengeToString()) ~ \($0.end.challengeToString())"
                if ($0.goalType == "DISTANCE") {
                    self.targetDistanceLabel.text = "기간 내 \($0.goal)km 달성"
                } else {
                    self.targetDistanceLabel.text = "기간 내 \($0.goal)걸음 달성"
                }
                self.purposeLabel.text = $0.award
                self.challengeTextView.text = $0.content
            }).disposed(by: disposeBag)
    }
}

extension DetailedChallengeViewController {

    private func addSubviews() {
        view.addSubview(challengeScrollView)
        view.addSubview(participateView)
        view.addSubview(participateBtn)
        view.addSubview(profileImageView)
        view.addSubview(secondProfileImageView)
        view.addSubview(thirdProfileImageView)
        view.addSubview(peopleCountView)
        peopleCountView.addSubview(peopleCountLabel)
    challengeScrollView.addSubview(challengeContentView)
        [challengeImageView,
         challengeTitleLabel,
         schoolLabel,
         organizerImageView,
         organizerLable,
         challengePeriod,
         challengeGoal,
         challengeRewards,
         dateLabel,
         targetDistanceLabel,
         purposeLabel,
         currentProgressLabel,
         presentLabel,
         currentProgressView,
         currentPercentageLabel,
         currentDistanceLabel,
         challengeTextView
        ].forEach { challengeContentView.addSubview($0) }
    }

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
            $0.top.equalTo(challengeImageView.snp.bottom).offset(56)
            $0.leading.equalToSuperview().inset(20)
        }

        schoolLabel.snp.makeConstraints {
            $0.top.equalTo(challengeTitleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }

        organizerImageView.snp.makeConstraints {
            $0.top.equalTo(challengeTitleLabel.snp.bottom).offset(8)
            $0.height.width.equalTo(20)
        }

        organizerLable.snp.makeConstraints {
            $0.top.equalTo(challengeTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(organizerImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(20)
        }

        challengePeriod.snp.makeConstraints {
            $0.top.equalTo(schoolLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }

        challengeGoal.snp.makeConstraints {
            $0.top.equalTo(challengePeriod.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }

        challengeRewards.snp.makeConstraints {
            $0.top.equalTo(challengeGoal.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(schoolLabel.snp.bottom).offset(16)
            $0.trailing.equalToSuperview().inset(20)
        }

        targetDistanceLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(20)
        }

        purposeLabel.snp.makeConstraints {
            $0.top.equalTo(targetDistanceLabel.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(20)
        }

        currentProgressLabel.snp.makeConstraints {
            $0.top.equalTo(challengeRewards.snp.bottom).offset(16)
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

        participateBtn.snp.makeConstraints {
            $0.centerY.equalTo(participateView)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(40)
            $0.width.equalTo(164)
        }

        profileImageView.snp.makeConstraints {
            $0.centerY.equalTo(participateView)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(40)
        }

        secondProfileImageView.snp.makeConstraints {
            $0.centerY.equalTo(participateView)
            $0.leading.equalToSuperview().inset(40)
            $0.width.height.equalTo(40)
        }

        thirdProfileImageView.snp.makeConstraints {
            $0.centerY.equalTo(participateView)
            $0.leading.equalToSuperview().inset(64)
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
//
//        participantsLabel.snp.makeConstraints {
//            $0.top.equalTo(targetDistanceLabel.snp.bottom).offset(9)
//            $0.leading.equalTo(thirdProfileImageView.snp.trailing).offset(8)
//        }
    }
}
