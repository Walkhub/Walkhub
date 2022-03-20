import UIKit

import RxSwift
import RxCocoa

class SettingProfileViewController: UIViewController {

    var viewModel: EditProfileViewModel!
    private var disposeBag = DisposeBag()

    private let editProfileViewController = EditProfileViewController()
    private let searchSchoolViewController = SearchSchoolViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func bind() {
        let input = EditProfileViewModel.Input(
            getData: editProfileViewController.getData.asDriver(onErrorJustReturn: ()),
            profileImage: editProfileViewController.image.asDriver(onErrorJustReturn: []),
            name: editProfileViewController.nameTextField.rx.text.orEmpty.asDriver(),
            buttonDidTap: editProfileViewController.editBtn.rx.tap.asDriver(),
            search: (searchSchoolViewController.navigationItem.searchController?.searchBar.searchTextField.rx.text.orEmpty.asDriver())!,
            cellTap: searchSchoolViewController.schoolTableView.rx.itemSelected.asDriver()
        )

        let output = viewModel.transform(input)

        output.searchSchool.bind(to: searchSchoolViewController.schoolTableView.rx.items(
            cellIdentifier: "cell",
            cellType: SchoolListTableViewCell.self
        )) { _, item, cell in
            cell.schoolNameLabel.text = item.name
            cell.logoImgView.kf.setImage(with: item.logoImageUrl)
        }.disposed(by: disposeBag)

        output.profile.asObservable().subscribe(onNext: {
            self.editProfileViewController.nameTextField.text = $0.name
            self.editProfileViewController.schoolLabel.text = $0.school
            self.editProfileViewController.profileImgView.kf.setImage(with: $0.profileImageUrl)
            if $0.grade == 0 || $0.classNum == 0 {
                self.editProfileViewController.gradeClassLabel.text = "현재 소속 중인 반이 없어요."
            } else {
                self.editProfileViewController.gradeClassLabel.text = "\($0.grade)학년 \($0.classNum)반"
            }
        }).disposed(by: disposeBag)

        output.schoolInfo.asObservable().subscribe(onNext: {
            self.editProfileViewController.schoolLabel.text = $0.name
            self.editProfileViewController.gradeClassLabel.text = "현재 소속 중인 반이 없어요."
        }).disposed(by: disposeBag)
    }
}
