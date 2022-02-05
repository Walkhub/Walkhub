import UIKit

import SnapKit
import Then

class HubViewController: UIViewController {

    private let searchBar = UISearchBar().then {
        $0.placeholder = "학교 검색"
        $0.backgroundColor = .init(named: "EEEEEE")
        $0.layer.cornerRadius = 8
    }
    private let mySchoolLabel = UILabel().then {
        $0.text = "내 학교"
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let mySchoolView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }

    private let schoolImgView = UIImageView().then {
        $0.image = .init(named: "clock.fill")
        $0.layer.cornerRadius = $0.frame.width / 2
    }

    private let schoolName = UILabel().then {
        $0.text = "대덕소프트웨어마이스터고등학교"
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let gradeClassLabel = UILabel().then {
        $0.text = "3학년 3반"
        $0.textColor = .init(named: "424242")
        $0.font = .notoSansFont(ofSize: 12, family: .regular)
    }

    private let top100Label = UILabel().then {
        $0.text = "걸음수 Top 100"
        $0.font = .notoSansFont(ofSize: 16, family: .medium)
    }

    private let rankTableView = UITableView().then {
        $0.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "허브"
    }
}
