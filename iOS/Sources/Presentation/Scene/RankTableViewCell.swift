import UIKit

class RankTableViewCell: UITableViewCell {

    let rankImageView = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 15
        $0.image = .init(systemName: "circle.fill")
        $0.tintColor = .init(named: "F9F9F9")!
    }

    let rankNameLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    let rankStepLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
    }
    
    let rankLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }
    
//    let rankBtn = UIButton().then {
//        $0.setTitle("모두보기", for: .normal)
//        $0.setTitleColor(.black, for: .normal)
//        $0.backgroundColor = .init(named: "F9F9F9")
//        $0.layer.cornerRadius = 10
//    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        demoData()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    private func demoData() {
        rankNameLabel.text = "정 환"
        rankStepLabel.text = "7482 걸음"
        rankLabel.text = "1등"
    }
    
    private func setUp() {
        self.addSubview(rankImageView)
        self.addSubview(rankNameLabel)
        self.addSubview(rankStepLabel)
        self.addSubview(rankLabel)
//        self.addSubview(rankBtn)
        
        
        rankImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.height.width.equalTo(40)
        }
        
        rankNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(19)
            $0.leading.equalTo(rankImageView.snp.trailing).offset(18)
        }

        rankStepLabel.snp.makeConstraints {
            $0.top.equalTo(rankNameLabel.snp.bottom)
            $0.leading.equalTo(rankImageView.snp.trailing).offset(18)
            $0.bottom.equalToSuperview()
        }

        rankLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(28)
            $0.trailing.equalToSuperview().inset(18)
        }
        
//        rankBtn.snp.makeConstraints {
//            $0.top.equalTo(rankStepLabel.snp.bottom).offset(20)
//            $0.leading.trailing.equalToSuperview().inset(15)
//            $0.height.equalTo(40)
//            $0.bottom.equalToSuperview().inset(12)
//        }
    }
}
