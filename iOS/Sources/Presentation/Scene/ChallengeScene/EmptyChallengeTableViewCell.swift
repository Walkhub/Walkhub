import UIKit

class EmptyChallengeTableViewCell: UITableViewCell {

    private let emptyChallengeLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.text = "참여 중인 챌린지가 없어요."
        $0.textColor = .gray700
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension EmptyChallengeTableViewCell {

    private func addSubviews() {
    [emptyChallengeLabel]
            .forEach { self.addSubview($0) }
    }

    private func makeSubviewConstraints() {

        emptyChallengeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
    }
}
