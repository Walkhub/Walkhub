import UIKit

import SnapKit
import RxCocoa
import RxSwift

class SchoolRegistrationViewController: UIViewController {

    var disposeBag = DisposeBag()

    private let searchTableView = UITableView().then {
        $0.backgroundColor = .white
        $0.isHidden = true
        $0.register(SchoolRegistrationTableViewCell.self, forCellReuseIdentifier: "schoolRegistrationCell")
    }

    private let schoolNameSearchBar = UISearchController().then {
        $0.searchBar.placeholder = "학교 이름으로 검색하기"
        $0.searchBar.showsCancelButton = false
        $0.searchBar.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
    }

    private let schoolResistrationProgressBar = UIProgressView().then {
        $0.progressViewStyle = .bar
        $0.progressTintColor = .primary400
        $0.trackTintColor = .gray400
        $0.progress = 0.64
    }

    private let searchBtn = UIBarButtonItem(image: .init(systemName: "arrow.backward"), style: .plain, target: self, action: nil)

    private let infoLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
    }

    private let backBtn = UIBarButtonItem().then {
        $0.image = .init(systemName: "arrow.backward")
        $0.tintColor = .gray500
    }

    private let schoolRegistrationLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 24, family: .bold)
        $0.text = "학교 등록"
    }

    private let belongSchoolLabel = UILabel().then {
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.text = "현재 소속 중인 학교를 등록해주세요."
        $0.textColor = .gray600
    }

    private let searchSchoolTextField = UITextField().then {
        $0.borderStyle = .roundedRect
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.gray400.cgColor
        $0.borderStyle = UITextField.BorderStyle.none
        $0.placeholder = "학교 검색하기"
        $0.font = .notoSansFont(ofSize: 14, family: .regular)
        $0.addLeftPadding()
    }

    private let continueBtn = UIButton(type: .system).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("계속하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
        $0.setBackgroundColor(.primary400, for: .normal)
        $0.setBackgroundColor(.gray300, for: .disabled)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setTextField()
        addSubviews()
        makeSubviewConstraints()
        searchSchoolTextField.delegate = self
        schoolNameSearchBar.searchBar.delegate = self
    }

    override func viewDidLayoutSubviews() {
        continueBtn.layer.masksToBounds = true
    }

    private func setNavigation() {
        navigationItem.leftBarButtonItem = backBtn
        self.navigationItem.searchController = nil
        self.navigationItem.leftBarButtonItem = backBtn
    }

    private func setTextField() {
        searchSchoolTextField.rx.text.orEmpty
        .map { $0 != "" }
        .bind(to: continueBtn.rx.isEnabled)
        .disposed(by: disposeBag)
    }
}

extension SchoolRegistrationViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.navigationItem.searchController = schoolNameSearchBar
        Observable<Int>.interval(.seconds(0), scheduler: MainScheduler.instance)
            .subscribe(onNext: {_ in
                self.schoolNameSearchBar.searchBar.searchTextField.becomeFirstResponder()
            }).disposed(by: disposeBag)
        searchTableView.isHidden = false
        return true
    }
}

extension SchoolRegistrationViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchSchoolTextField.text = searchBar.text
        self.navigationItem.searchController = nil
        self.view.endEditing(true)
        searchTableView.isHidden = true
    }
}

extension SchoolRegistrationViewController {
    private func addSubviews() {
        [schoolRegistrationLabel, belongSchoolLabel, searchSchoolTextField, continueBtn, infoLabel, schoolResistrationProgressBar, searchTableView]
            .forEach { view.addSubview($0) }
    }

    private func makeSubviewConstraints() {
        schoolRegistrationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.equalToSuperview().inset(16)
        }

        belongSchoolLabel.snp.makeConstraints {
            $0.top.equalTo(schoolRegistrationLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
        }

        searchSchoolTextField.snp.makeConstraints {
            $0.top.equalTo(belongSchoolLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }

        continueBtn.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(30)
        }

        infoLabel.snp.makeConstraints {
            $0.top.equalTo(searchSchoolTextField.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
        }

        schoolResistrationProgressBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
            $0.trailing.leading.equalToSuperview()
        }

        searchTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
