import UIKit

import SnapKit
import RxSwift
import RxCocoa
import RxFlow
import Pageboy

class AgreeTermsViewController: UIViewController, Stepper {

    var name = String()
    var phoneNumber = String()
    var authCode = String()
    var id = String()
    var password = String()
    var schoolId = Int()

    var viewModel: AgreeTermsViewModel!

    private var disposeBag = DisposeBag()
    var steps = PublishRelay<Step>()
    private let allAgree = BehaviorRelay<Bool>(value: false)
    private let termsAgree = BehaviorRelay<Bool>(value: false)
    private let personalAgree = BehaviorRelay<Bool>(value: false)

    private let allAgreeView = UIView().then {
        $0.backgroundColor = .gray50
        $0.layer.cornerRadius = 12
    }
    private let termsView = UIView().then {
        $0.backgroundColor = .white
    }
    private let personalInformationView = UIView().then {
        $0.backgroundColor = .white
    }
    private let allAgreeLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.text = "약관 전체동의"
    }
    private let termsLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.text = "이용약관(필수)"
    }
    private let personalInfomationLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.text = "개인정보 취급방침(필수)"
    }
    private let allAgreeBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        $0.tintColor = .gray700
        $0.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        $0.tintColor = .primary400
    }
    private let termsBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        $0.tintColor = .gray700
        $0.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        $0.tintColor = .primary400
    }
    private let personalInformationBtn = UIButton().then {
        $0.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        $0.tintColor = .gray700
        $0.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        $0.tintColor = .primary400
    }
    private let agreeTermsProgressBar = UIProgressView().then {
        $0.progressViewStyle = .bar
        $0.progressTintColor = .primary400
        $0.trackTintColor = .gray400
        $0.progress = 0.8
    }
    private let infoLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }
    private let backBtn = UIBarButtonItem().then {
        $0.image = .init(systemName: "arrow.backward")
        $0.tintColor = .gray500
    }
    private let agreeTermsLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
        $0.text = "약관동의"
    }
    private let finishSignUpLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray600
        $0.text = "Walkhub 회원가입을 마무리하기 위해"
    }
    private let agreeServiceLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray600
        $0.text = "서비스 이용 약관에 동의해주세요."
    }
    let completeBtn = UIButton(type: .system).then {
        $0.setTitle("회원가입 완료하기", for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.setBackgroundColor(.gray300, for: .disabled)
        $0.setBackgroundColor(.primary400, for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setBtn()
        bind()
        view.backgroundColor = .white
    }

    override func viewDidLayoutSubviews() {
        completeBtn.layer.masksToBounds = true
        addSubviews()
        makeSubviewConstraints()
    }

    private func setBtn() {
        allAgree.bind(to: allAgreeBtn.rx.isSelected).disposed(by: disposeBag)
        allAgree.bind(to: completeBtn.rx.isEnabled).disposed(by: disposeBag)
        termsAgree.bind(to: termsBtn.rx.isSelected).disposed(by: disposeBag)
        personalAgree.bind(to: personalInformationBtn.rx.isSelected).disposed(by: disposeBag)

        allAgreeBtn.rx.tap
            .subscribe(onNext: { _ in
                if self.allAgreeBtn.isSelected {
                    [self.allAgree, self.termsAgree, self.personalAgree]
                        .forEach { $0.accept(false) }
                } else {
                    [self.allAgree, self.termsAgree, self.personalAgree]
                        .forEach { $0.accept(true) }
                }
            }).disposed(by: disposeBag)

        termsBtn.rx.tap
            .subscribe(onNext: { _ in
                if !self.termsBtn.isSelected && self.personalInformationBtn.isSelected {
                    self.termsAgree.accept(true)
                    self.allAgree.accept(true)
                } else if !self.termsBtn.isSelected {
                    self.termsAgree.accept(true)
                } else {
                    self.termsAgree.accept(false)
                    self.allAgree.accept(false)
                }
            }).disposed(by: disposeBag)

        personalInformationBtn.rx.tap
            .subscribe(onNext: { _ in
                if !self.personalInformationBtn.isSelected && self.termsBtn.isSelected {
                    self.personalAgree.accept(true)
                    self.allAgree.accept(true)
                } else if !self.personalInformationBtn.isSelected {
                    self.personalAgree.accept(true)
                } else {
                    self.personalAgree.accept(false)
                    self.allAgree.accept(false)
                }
            }).disposed(by: disposeBag)
    }

    private func setNavigation() {
        navigationController?.navigationBar.setBackButtonToArrow()
    }

    private func bind() {
        let input = AgreeTermsViewModel.Input(
            name: name,
            phoneNumber: phoneNumber,
            authCode: authCode,
            id: id,
            password: password,
            schoolId: schoolId,
            signupButtonDidTap: completeBtn.rx.tap.asDriver()
        )
        _ = viewModel.transform(input)
    }
}

extension AgreeTermsViewController {

    private func addSubviews() {
        [completeBtn,
         agreeTermsLabel,
         infoLabel,
         agreeTermsProgressBar,
         finishSignUpLabel,
         agreeServiceLabel,
         allAgreeView,
         allAgreeLabel,
         allAgreeBtn,
         termsView,
         termsLabel,
         termsBtn,
         personalInformationView,
         personalInfomationLabel,
         personalInformationBtn
        ].forEach { view.addSubview($0) }
    }

    private func makeSubviewConstraints() {

        agreeTermsLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(16)
        }
        completeBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(30)
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(agreeTermsLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
        }
        agreeTermsProgressBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
            $0.trailing.leading.equalToSuperview()
        }
        finishSignUpLabel.snp.makeConstraints {
            $0.top.equalTo(agreeTermsLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
        }
        agreeServiceLabel.snp.makeConstraints {
            $0.top.equalTo(finishSignUpLabel.snp.bottom).offset(1)
            $0.leading.equalToSuperview().inset(16)
        }
        allAgreeView.snp.makeConstraints {
            $0.top.equalTo(agreeServiceLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(52)
            $0.centerX.equalToSuperview()
        }
        allAgreeLabel.snp.makeConstraints {
            $0.centerY.equalTo(allAgreeView)
            $0.trailing.equalTo(allAgreeView.snp.trailing).inset(20)
        }
        allAgreeBtn.snp.makeConstraints {
            $0.centerY.equalTo(allAgreeView)
            $0.leading.equalTo(allAgreeView.snp.leading).offset(24)
            $0.height.width.equalTo(20)
        }
        termsView.snp.makeConstraints {
            $0.top.equalTo(allAgreeView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(52)
            $0.centerX.equalToSuperview()
        }
        termsLabel.snp.makeConstraints {
            $0.centerY.equalTo(termsView)
            $0.trailing.equalTo(termsView.snp.trailing).inset(20)
        }
        termsBtn.snp.makeConstraints {
            $0.centerY.equalTo(termsView)
            $0.leading.equalTo(termsView.snp.leading).offset(24)
            $0.height.width.equalTo(20)
        }
        personalInformationView.snp.makeConstraints {
            $0.top.equalTo(termsView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(52)
            $0.centerX.equalToSuperview()
        }
        personalInfomationLabel.snp.makeConstraints {
            $0.centerY.equalTo(personalInformationView)
            $0.trailing.equalTo(personalInformationView.snp.trailing).inset(20)
        }
        personalInformationBtn.snp.makeConstraints {
            $0.centerY.equalTo(personalInformationView)
            $0.leading.equalTo(personalInformationView.snp.leading).offset(24)
            $0.height.width.equalTo(20)
        }
    }

}
