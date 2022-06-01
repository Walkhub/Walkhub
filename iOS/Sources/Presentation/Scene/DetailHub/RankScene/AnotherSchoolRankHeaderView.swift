import UIKit

class AnotherSchoolRankHeaderView: UIView {

    private let top100Label = UILabel().then {
        $0.text = "걸음수 Top 100"
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    internal let dropDownBtn = DropDownButton().then {
        $0.setTitle(" 오늘\t", for: .normal)
        $0.arr = [" 오늘", "이번주", "이번달"]
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeSubviewConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension AnotherSchoolRankHeaderView {
    private func addSubviews() {
        [top100Label, dropDownBtn].forEach { self.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        top100Label.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(14)
        }

        dropDownBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(78)
            $0.height.equalTo(36)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
}
