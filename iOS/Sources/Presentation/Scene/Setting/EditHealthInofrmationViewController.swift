import UIKit

import SnapKit
import Then
import RxSwift
import RxCocoa

class EditHealthInofrmationViewController: UIViewController {

    private var disposeBag = DisposeBag()

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
        $0.titleLabel?.font = .notoSansFont(ofSize: 16, family: .regular)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "건강정보 수정"
        setBtn()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewConstraints()
    }

    private func setBtn() {
        maleBtn.rx.tap.subscribe(onNext: {
            self.maleBtn.isSelected = true
            self.femaleBtn.isSelected = false
        }).disposed(by: disposeBag)

        femaleBtn.rx.tap.subscribe(onNext: {
            self.femaleBtn.isSelected = true
            self.maleBtn.isSelected = false
        }).disposed(by: disposeBag)
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
            $0.width.equalTo(160)
            $0.height.equalTo(52)
        }

        femaleBtn.snp.makeConstraints {
            $0.top.equalTo(weightView.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(160)
            $0.height.equalTo(52)
        }

        doneBtn.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(52)
        }
    }
}
