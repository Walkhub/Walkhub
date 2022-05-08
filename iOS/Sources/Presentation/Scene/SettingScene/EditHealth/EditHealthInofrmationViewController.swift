import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa
import Service

class EditHealthInofrmationViewController: UIViewController {

    var viewModel: EditHealthInformationViewModel!
    private var disposeBag = DisposeBag()
    private let getData = PublishRelay<Void>()
    private let sex = PublishRelay<Sex>()
    private let height = PublishRelay<String>()
    private let weight = PublishRelay<String>()

    private let heightView = UIView().then {
        $0.layer.borderColor = UIColor.colorBDBDBD.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 12
    }

    private let heightTextField = UITextField().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let cmLabel = UILabel().then {
        $0.text = "cm"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let weightView = UIView().then {
        $0.layer.borderColor = UIColor.colorBDBDBD.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 12
    }

    private let weightTextField = UITextField().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let kgLabel = UILabel().then {
        $0.text = "kg"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let maleBtn = UIButton().then {
        $0.setTitle("남성", for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.setTitleColor(.gray800, for: .normal)
        $0.setBackgroundColor(.primary400, for: .selected)
        $0.setBackgroundColor(.gray50, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }

    private let femaleBtn = UIButton().then {
        $0.setTitle("여성", for: .normal)
        $0.setTitleColor(.white, for: .selected)
        $0.setTitleColor(.gray800, for: .normal)
        $0.setBackgroundColor(.primary400, for: .selected)
        $0.setBackgroundColor(.gray50, for: .normal)
        $0.titleLabel?.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }

    private let doneBtn = UIButton(type: .system).then {
        $0.setBackgroundColor(.primary400, for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("수정 완료", for: .normal)
        $0.setBackgroundColor(.colorE0E0E0, for: .disabled)
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "건강정보 수정"
        view.backgroundColor = .white
        setBtn()
        setTextField()
        bindViewModel()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
        doneBtn.layer.cornerRadius = 12
        doneBtn.clipsToBounds = true
    }

    override func viewWillAppear(_ animated: Bool) {
        getData.accept(())
        doneBtn.isEnabled = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    private func setBtn() {
        maleBtn.rx.tap.subscribe(onNext: {
            if self.maleBtn.isSelected {
                self.maleBtn.isSelected = false
                self.doneBtn.isEnabled = false
                self.sex.accept(.noAnswer)
            } else {
                self.maleBtn.isSelected = true
                self.femaleBtn.isSelected = false
                self.doneBtn.isEnabled = true
                self.sex.accept(.man)
            }
        }).disposed(by: disposeBag)

        femaleBtn.rx.tap.subscribe(onNext: {
            if self.femaleBtn.isSelected {
                self.femaleBtn.isSelected = false
                self.doneBtn.isEnabled = false
                self.sex.accept(.noAnswer)
            } else {
                self.femaleBtn.isSelected = true
                self.maleBtn.isSelected = false
                self.doneBtn.isEnabled = true
                self.sex.accept(.female)
            }
        }).disposed(by: disposeBag)

        if !maleBtn.isSelected && !femaleBtn.isSelected {
            doneBtn.isEnabled = false
        }
    }

    private func setTextField() {
        heightTextField.delegate = self
        weightTextField.delegate = self
        heightTextField.keyboardType = .numbersAndPunctuation
        weightTextField.keyboardType = .numbersAndPunctuation

        height.bind(to: heightTextField.rx.text.orEmpty)
            .disposed(by: disposeBag)

        weight.bind(to: weightTextField.rx.text.orEmpty)
            .disposed(by: disposeBag)
    }

    private func bindViewModel() {
        let input = EditHealthInformationViewModel.Input(
            getData: getData.asDriver(onErrorJustReturn: ()),
            height: height.asDriver(onErrorJustReturn: ""),
            weight: weight.asDriver(onErrorJustReturn: ""),
            sex: sex.asDriver(onErrorJustReturn: .noAnswer),
            postData: doneBtn.rx.tap.asDriver())

        let output = viewModel.transform(input)

        output.healthData.asObservable()
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: {
                self.height.accept(String($0.height))
                self.weight.accept(String($0.weight))
                self.heightTextField.text = "\($0.height)"
                self.weightTextField.text = "\($0.weight)"
                if $0.sex == .man {
                    self.maleBtn.isSelected = true
                    self.femaleBtn.isSelected = false
                    self.sex.accept(.man)
                } else if $0.sex == .female {
                    self.maleBtn.isSelected = false
                    self.femaleBtn.isSelected = true
                    self.sex.accept(.female)
                } else {
                    self.maleBtn.isSelected = false
                    self.femaleBtn.isSelected = false
                    self.sex.accept(.noAnswer)
                }
            }).disposed(by: disposeBag)
    }
}

extension EditHealthInofrmationViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == heightTextField {
            self.height.accept(heightTextField.text ?? "")
        } else {
            self.weight.accept(weightTextField.text ?? "")
        }
        doneBtn.isEnabled = true
    }
}

extension EditHealthInofrmationViewController {
    private func addSubviews() {
        [heightView, weightView, maleBtn, femaleBtn, doneBtn].forEach { view.addSubview($0) }

        [heightTextField, cmLabel].forEach { heightView.addSubview($0) }

        [weightTextField, kgLabel].forEach { weightView.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        heightView.snp.makeConstraints {
            $0.top.equalTo(view.snp.topMargin).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        heightTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(cmLabel.snp.leading).offset(-10)
        }

        cmLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }

        weightView.snp.makeConstraints {
            $0.top.equalTo(heightView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        weightTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(46)
        }

        kgLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }

        maleBtn.snp.makeConstraints {
            $0.top.equalTo(weightView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.width.greaterThanOrEqualTo(160)
            $0.trailing.equalTo(femaleBtn.snp.leading).offset(-8)
            $0.height.equalTo(52)
        }

        femaleBtn.snp.makeConstraints {
            $0.top.equalTo(weightView.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(maleBtn)
            $0.height.equalTo(52)
        }

        doneBtn.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
    }
}
