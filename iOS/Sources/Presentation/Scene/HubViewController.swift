import UIKit

import SnapKit
import Then

class HubViewController: UIViewController {

    private let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = "학교 검색"
        $0.searchBar.layer.cornerRadius = 8
        $0.navigationItem.hidesSearchBarWhenScrolling = false
        $0.hidesNavigationBarDuringPresentation = false
        $0.automaticallyShowsCancelButton = false
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
        $0.image = .init(systemName: "clock.fill")
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
        $0.register(SchoolRankTableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
    }

    override func viewDidLayoutSubviews() {
        addSubviews()
        makeSubviewContraints()
    }

    private func addSubviews() {
        [mySchoolLabel, mySchoolView, top100Label, rankTableView]
            .forEach { view.addSubview($0) }

        [schoolImgView, schoolName, gradeClassLabel]
            .forEach { mySchoolView.addSubview($0) }
    }

    private func makeSubviewContraints() {
        mySchoolLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaInsets).offset(140)
            $0.leading.equalToSuperview().inset(16)
        }

        mySchoolView.snp.makeConstraints {
            $0.top.equalTo(mySchoolLabel.snp.bottom).offset(9)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(64)
        }

        schoolImgView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(40)
        }

        schoolName.snp.makeConstraints {
            $0.top.equalToSuperview().inset(11)
            $0.leading.equalTo(schoolImgView.snp.trailing).offset(16)
        }

        gradeClassLabel.snp.makeConstraints {
            $0.top.equalTo(schoolName.snp.bottom)
            $0.leading.equalTo(schoolImgView.snp.trailing).offset(16)
        }

        top100Label.snp.makeConstraints {
            $0.top.equalTo(mySchoolView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }

        rankTableView.snp.makeConstraints {
            $0.top.equalTo(top100Label.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension HubViewController {
    private func setNavigation() {
        navigationItem.searchController = searchController
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.text = "허브"
        titleLabel.font = .notoSansFont(ofSize: 20, family: .medium)
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
       self.navigationItem.titleView = titleLabel
       guard let containerView = self.navigationItem.titleView?.superview else { return }

        let leftBarItemWidth = self.navigationItem.leftBarButtonItems?.reduce(0, { $0 + $1.width })
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor,
                                            constant: (leftBarItemWidth ?? 0) + 16),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor)
               ])
    }
}
