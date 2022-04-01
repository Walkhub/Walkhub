import UIKit

import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {

    var viewModel: SignUpViewModel!

    private let enterNameViewController = EnterNameViewController()
    private let certifyPhoneNumberViewController = CertifyPhoneNumberViewController()
    private let authenticationNumberViewController = AuthenticationNumberViewController()
    private let idViewController = IDViewController()
    private let enterPasswordViewController = EnterPasswordViewController()
    private let schoolRegistrationViewController = SchoolRegistrationViewController()
    private let enterHealthInformationViewController = EnterHealthInformationViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    private func bind() {
        let input = SignUpViewModel.Input(
            id: idViewController.idTextField.rx.text.orEmpty.asDriver(),
            password: enterPasswordViewController.pwTextField.rx.text.orEmpty.asDriver(),
            name: enterNameViewController.nameTextField.rx.text.orEmpty.asDriver(),
            phoneNumber: certifyPhoneNumberViewController.phoneNumberTextField.rx.text.orEmpty.asDriver(),
            authCode: authenticationNumberViewController.authenticationNumberTextField.rx.text.orEmpty.asDriver(),
            height: enterHealthInformationViewController.heightTextField.rx.text.orEmpty.asDriver(),
            weight: enterHealthInformationViewController.weightTextField.rx.text.orEmpty.asDriver(),
            sex: enterHealthInformationViewController.sex.asDriver(onErrorJustReturn: .noAnswer),
            schoolId: schoolRegistrationViewController.schoolId.asDriver(onErrorJustReturn: 0),
            signupButtonDidTap: enterHealthInformationViewController.completeBtn.rx.tap.asDriver(),
            toLaterButtonDidTap: enterHealthInformationViewController.doLaterBtn.rx.tap.asDriver()
        )

        _ = viewModel.transform(input)
    }
}
