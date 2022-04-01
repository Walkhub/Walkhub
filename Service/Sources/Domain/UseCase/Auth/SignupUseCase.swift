// swiftlint:disable function_parameter_count

import Foundation

import RxSwift

public class SignupUseCase {

    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    public func excute(
        id: String,
        password: String,
        name: String,
        phoneNumber: String,
        authCode: String,
        height: Float?,
        weight: Int?,
        sex: Sex,
        schoolId: Int
    ) -> Completable {
        authRepository.signup(
            id: id,
            password: password,
            name: name,
            phoneNumber: phoneNumber,
            authCode: authCode,
            height: height,
            weight: weight,
            sex: sex,
            schoolId: schoolId
        )
    }

}
