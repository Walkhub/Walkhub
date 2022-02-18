import UIKit

import DropDown
import SnapKit
import Then
import RxSwift
import RxCocoa

class DropDownButton: UIButton {

    var arr = [String]()

    private var disposeBag = DisposeBag()

    lazy var dropDown = DropDown().then {
        $0.dataSource = arr
        $0.anchorView = self
        $0.backgroundColor = .gray50
        $0.textFont = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray800
        $0.bottomOffset = CGPoint(x: 0, y: 36)
        $0.width = 94
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setDropDownBtn()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setDropDownBtn() {
        self.setBackgroundColor(.gray50, for: .normal)
        self.setTitleColor(.gray800, for: .normal)
        self.setImage(.init(systemName: "chevron.down"), for: .normal)
        self.tintColor = .gray800
        self.setPreferredSymbolConfiguration(.init(
            pointSize: 10,
            weight: .regular,
            scale: .small
        ), forImageIn: .normal)
        self.semanticContentAttribute = .forceRightToLeft
        self.titleLabel?.font = .notoSansFont(ofSize: 14, family: .regular)

        self.snp.makeConstraints {
            $0.width.equalTo(94)
            $0.height.equalTo(36)
        }

        self.rx.tap.subscribe(onNext: { [weak self] in
            self?.dropDown.show()
        }).disposed(by: disposeBag)
    }
}
