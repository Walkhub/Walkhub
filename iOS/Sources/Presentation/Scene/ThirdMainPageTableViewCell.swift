import UIKit

class ThirdMainPageTableViewCell: UITableViewCell {

    let watchBtn = UIButton().then {

        $0.layer.cornerRadius = 10
        $0.setTitle("모두보기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .init(named: "F9F9F9")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    private func setUp() {
        self.addSubview(watchBtn)
        
        watchBtn.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.height.equalTo(45)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
