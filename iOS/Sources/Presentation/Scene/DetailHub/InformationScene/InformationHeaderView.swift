import UIKit

class InformationHeaderView: UIView {
    // MARK: - UI
    internal let schoolInfoLabel = UILabel().then {
        $0.text = "학교 정보"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray600
    }
    internal let lastWeekTotalWalkCountLabel = UILabel().then {
        $0.text = "지난주 걸음수 총합"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray800
    }
    internal let lastWeekDateLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray700
    }
    internal let lastWeekTotalWalkCountAndUserCountLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
        $0.textColor = .black
    }
    internal let lastWeekBadgeImageView = UIImageView().then {
        $0.backgroundColor = .white
        $0.contentMode = .scaleAspectFit
    }
    internal let lastWeekWalkCountRankingLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
        $0.textColor = .black
    }
    internal let lastMonthTotalWalkCountLabel = UILabel().then {
        $0.text = "지난달 걸음수 총합"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray800
    }
    internal let lastMonthDateLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray700
    }
    internal let lastMonthToalWalkCountAndUserCountLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
        $0.textColor = .black
    }
    internal let lastMonthBadgeImageView = UIImageView().then {
        $0.backgroundColor = .white
        $0.contentMode = .scaleAspectFit
    }
    internal let lastMonthWalkCountRankingLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
        $0.textColor = .black
    }
    internal let noticeLabel = UILabel().then {
        $0.text = "공지사항"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray600
    }
    internal let line = UIView().then {
        $0.backgroundColor = .gray200
    }

    // MARK: - Life Cycle
    override func layoutSubviews() {
        addSubviews()
        makeSubviewConstraits()
    }
}

// MARK: - Layout
extension InformationHeaderView {
    func addSubviews() {
        [schoolInfoLabel, lastWeekTotalWalkCountLabel, lastWeekDateLabel,
         lastWeekTotalWalkCountAndUserCountLabel, lastWeekBadgeImageView,
         lastWeekWalkCountRankingLabel, lastMonthTotalWalkCountLabel, lastMonthDateLabel,
        lastMonthToalWalkCountAndUserCountLabel, lastMonthBadgeImageView,
         lastMonthWalkCountRankingLabel, line, noticeLabel].forEach { self.addSubview($0) }
    }
    func makeSubviewConstraits() {
        schoolInfoLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(16)
        }
        lastWeekTotalWalkCountLabel.snp.makeConstraints {
            $0.top.equalTo(schoolInfoLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(16)
        }
        lastWeekDateLabel.snp.makeConstraints {
            $0.top.equalTo(lastWeekTotalWalkCountLabel.snp.top)
            $0.leading.equalTo(lastWeekTotalWalkCountLabel.snp.trailing).offset(8)
        }
        lastWeekTotalWalkCountAndUserCountLabel.snp.makeConstraints {
            $0.top.equalTo(lastWeekTotalWalkCountLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(16)
        }
        lastWeekBadgeImageView.snp.makeConstraints {
            $0.centerY.equalTo(lastWeekWalkCountRankingLabel)
            $0.trailing.equalTo(lastWeekWalkCountRankingLabel.snp.leading).offset(-11)
            $0.width.equalTo(14)
            $0.height.equalTo(16)
        }
        lastWeekWalkCountRankingLabel.snp.makeConstraints {
            $0.top.equalTo(lastWeekDateLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
        }
        lastMonthTotalWalkCountLabel.snp.makeConstraints {
            $0.top.equalTo(lastWeekTotalWalkCountAndUserCountLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }
        lastMonthDateLabel.snp.makeConstraints {
            $0.top.equalTo(lastMonthTotalWalkCountLabel.snp.top)
            $0.leading.equalTo(lastMonthTotalWalkCountLabel.snp.trailing).offset(8)
        }
        lastMonthToalWalkCountAndUserCountLabel.snp.makeConstraints {
            $0.top.equalTo(lastMonthDateLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(16)
        }
        lastMonthBadgeImageView.snp.makeConstraints {
            $0.centerY.equalTo(lastMonthWalkCountRankingLabel)
            $0.trailing.equalTo(lastMonthWalkCountRankingLabel.snp.leading).offset(-11)
            $0.width.equalTo(14)
            $0.height.equalTo(16)
        }
        lastMonthWalkCountRankingLabel.snp.makeConstraints {
            $0.top.equalTo(lastMonthDateLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
        }
        lastMonthDateLabel.snp.makeConstraints {
            $0.top.equalTo(lastWeekDateLabel.snp.bottom).offset(40)
            $0.leading.equalTo(lastMonthTotalWalkCountLabel.snp.trailing).offset(16)
        }
        line.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(lastMonthToalWalkCountAndUserCountLabel.snp.bottom).offset(16)
        }
        noticeLabel.snp.makeConstraints {
            $0.top.equalTo(line.snp.bottom).offset(11)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(12)
        }
    }
}
