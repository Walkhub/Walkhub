//
//  DisableChallengeTableViewCell.swift
//  Walkhub
//
//  Created by kimsian on 2022/02/28.
//  Copyright © 2022 com.walkhub. All rights reserved.
//

import UIKit

class DisableChallengeTableViewCell: UITableViewCell {

    private let disableChallengeLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.textColor = .gray700
        $0.text = "참여 할 수 있는 챌린지가 없어요."
        $0.isHidden = true
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

extension DisableChallengeTableViewCell {

    private func addSubviews() {
    [disableChallengeLabel]
            .forEach { self.addSubview($0) }
    }

    private func makeSubviewConstraints() {

        disableChallengeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
    }
}
