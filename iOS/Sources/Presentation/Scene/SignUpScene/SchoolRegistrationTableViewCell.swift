import UIKit

class SchoolRegistrationTableViewCell: UITableViewCell {

    let schoolLogoImageView = UIImageView().then {
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    let schoolNameLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        makeSubviewContraints()
    }
}

extension SchoolRegistrationTableViewCell {
    private func addSubviews() {
        [schoolLogoImageView, schoolNameLabel]
            .forEach { self.addSubview($0) }
    }

    private func makeSubviewContraints() {
        schoolLogoImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(32)
            $0.height.width.equalTo(40)
        }

        schoolNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalTo(schoolLogoImageView.snp.trailing).offset(16)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
