import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class DetailedChallengeViewController: UIViewController {

    var viewModel: DetailedChallengeViewModel!

    private let challengeId = PublishRelay<Int>()
    private var disposeBag = DisposeBag()

    private let challengeImageView = UIImageView().then {
        $0.image = .init(systemName: "photo.artframe")
        $0.tintColor = .gray800
    }

    private let challengeTitleLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
        $0.textColor = .gray900
    }

    private let organizerLable = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .medium)
        $0.textColor = .gray800
    }

    private let dateLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray700
    }

    private let schoolLogoImageView = UIImageView().then {
        $0.image = .init(systemName: "circle.fill")
        $0.tintColor = .gray800
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    private let targetDistanceLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }

    private let stepCountLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }

    private let pointImageView = UIImageView().then {
        $0.image = .init(systemName: "circle.fill")
        $0.tintColor = .gray800
    }

    private let dotImageView = UIImageView().then {
        $0.image = .init(systemName: "circle.fill")
        $0.tintColor = .gray800
    }

    private let purposeLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }

    private let challengeTextView = UITextView().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray800
    }

    private let profileImageView = UIImageView().then {
        $0.tintColor = .gray800
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    private let secondProfileImageView = UIImageView().then {
        $0.tintColor = .gray600
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    private let thirdProfileImageView = UIImageView().then {
        $0.tintColor = .gray400
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    private let participantsLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
        $0.textColor = .gray700
    }

    private let participateBtn = UIButton().then {
        $0.setTitle("참여하기", for: .normal)
        $0.backgroundColor = .primary400
        $0.layer.cornerRadius = 10
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        makeSubviewConstraints()
        demoData()
    }

    func demoData() {
        challengeTitleLabel.text = "2학년 체육 수행평가"
        organizerLable.text = "서무성"
        dateLabel.text = "2022/03/02 ~ 2022/03/31"
        targetDistanceLabel.text = "기간 내 20km 달성"
        purposeLabel.text = "체육 수행평가 성적"
        challengeTextView.text = "대덕소프트웨어마이스터고등학교 2학년 체육 수행평가입니다. 20km는 개쉽습니다. 사람 새끼면 걷고도 남습니다. 꼭하십쇼"
        participantsLabel.text = "최민준,김수완,수준호 외 21명 참여 중입니다."
    }

    override func viewWillAppear(_ animated: Bool) {
        challengeTextView.isEditable = false
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
        [challengeImageView,
         challengeTitleLabel,
         schoolLogoImageView,
         organizerLable,
         dateLabel,
         targetDistanceLabel,
         pointImageView,
         dotImageView,
         purposeLabel,
         challengeTextView,
         profileImageView,
         secondProfileImageView,
         thirdProfileImageView,
         participantsLabel,
         participateBtn
        ].forEach { view.addSubview($0) }
    }

    private func makeSubviewConstraints() {

        challengeImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(240)
        }

        schoolLogoImageView.snp.makeConstraints {
            $0.top.equalTo(challengeImageView.snp.bottom).offset(57)
            $0.leading.equalToSuperview().inset(32)
            $0.height.width.equalTo(40)
        }

        challengeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(challengeImageView.snp.bottom).offset(56)
            $0.leading.equalTo(schoolLogoImageView.snp.trailing).offset(15)
        }

        organizerLable.snp.makeConstraints {
            $0.top.equalTo(challengeTitleLabel.snp.bottom).offset(1)
            $0.leading.equalTo(schoolLogoImageView.snp.trailing).offset(16)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(challengeTitleLabel.snp.bottom).offset(1)
            $0.leading.equalTo(organizerLable.snp.trailing).offset(8)
        }

        targetDistanceLabel.snp.makeConstraints {
            $0.top.equalTo(organizerLable.snp.bottom).offset(11)
            $0.leading.equalToSuperview().inset(42)
        }

        pointImageView.snp.makeConstraints {
            $0.top.equalTo(challengeImageView.snp.bottom).offset(117)
            $0.leading.equalToSuperview().inset(32)
            $0.height.width.equalTo(4)
        }

        dotImageView.snp.makeConstraints {
            $0.top.equalTo(challengeImageView.snp.bottom).offset(117)
            $0.leading.equalTo(targetDistanceLabel.snp.trailing).offset(8)
            $0.height.width.equalTo(4)
        }

        purposeLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabel.snp.bottom).offset(11)
            $0.leading.equalTo(dotImageView.snp.trailing).offset(8)
        }

        profileImageView.snp.makeConstraints {
            $0.top.equalTo(targetDistanceLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(32)
            $0.height.width.equalTo(20)
        }

        secondProfileImageView.snp.makeConstraints {
            $0.top.equalTo(targetDistanceLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(44)
            $0.height.width.equalTo(20)
        }

        thirdProfileImageView.snp.makeConstraints {
            $0.top.equalTo(targetDistanceLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(56)
            $0.height.width.equalTo(20)
        }

        participantsLabel.snp.makeConstraints {
            $0.top.equalTo(targetDistanceLabel.snp.bottom).offset(9)
            $0.leading.equalTo(thirdProfileImageView.snp.trailing).offset(8)
        }

        challengeTextView.snp.makeConstraints {
            $0.top.equalTo(participantsLabel.snp.bottom).offset(11)
            $0.trailing.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(200)
        }

        participateBtn.snp.makeConstraints {
            $0.top.equalTo(challengeTextView.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(42)
            $0.width.equalTo(164)
        }
    }
}
