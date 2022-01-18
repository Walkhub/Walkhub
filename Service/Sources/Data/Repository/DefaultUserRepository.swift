import Foundation

import RxSwift
import Moya

class DefaultUserRepository: UserRepository {
    
    func changePassword(
        accountID: String,
        phoneNumber: String,
        authCode: String,
        newPassword: String
    ) -> Single<Void> {
        return UserService.shared.changePassword(
            accountID: accountID,
            phoneNumber: phoneNumber,
            authCode: authCode,
            newPassword: newPassword
        ).map { _ in
            return ()
        }.catch { error in
            if let moyaErr = error as? MoyaError {
                switch moyaErr.errorCode {
                case 404: return Single.error(WalkhubError.faildFound)
                default: return Single.error(error)
                }
            } else { return Single.error(error) }
        }
    }
    
    func profileInquiry(userID: Int) -> Single<UserProfileDTO> {
        return UserService.shared.profileInquiry(userID: userID)
            .map(UserProfileDTO.self)
            .map { return $0 }
            .catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError.errorCode {
                    case 401: return Single.error(WalkhubError.unauthorization)
                    case 404: return Single.error(WalkhubError.faildFound)
                    default: return Single.error(error)
                    }
                } else { return Single.error(error) }
            }
    }
    
    func myPageInquiry() -> Single<UserProfileDTO> {
        return UserService.shared.myPageInquiry()
            .map(UserProfileDTO.self)
            .map { return $0 }
            .catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError.errorCode {
                    case 401: return Single.error(WalkhubError.unauthorization)
                    case 404: return Single.error(WalkhubError.faildFound)
                    default: return Single.error(error)
                    }
                } else { return Single.error(error) }
            }
    }
    
    func badgeInquiry(userID: Int) -> Single<BadgeListDTO> {
        return UserService.shared.badgeInquiry(userID: userID)
            .map(BadgeListDTO.self)
            .map { return $0 }
            .catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError.errorCode {
                    case 401: return Single.error(WalkhubError.unauthorization)
                    case 404: return Single.error(WalkhubError.faildFound)
                    default: return Single.error(error)
                    }
                } else { return Single.error(error) }
            }
    }
    
    func mainBadgeSet(badgeID: Int) -> Single<Void> {
        return UserService.shared.mainBadgeSet(badgeID: badgeID)
            .map { _ in
                return ()
            }
            .catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError.errorCode {
                    case 401: return Single.error(WalkhubError.unauthorization)
                    case 404: return Single.error(WalkhubError.faildFound)
                    default: return Single.error(error)
                    }
                } else { return Single.error(error) }
            }
    }
    
    func changeProfile(
        name: String,
        profileImageUrlString: String,
        birthday: String,
        sex: String
    ) -> Single<Void> {
        return UserService.shared.changeProfile(
            name: name,
            profileImageUrlString: profileImageUrlString,
            birthday: birthday,
            sex: sex
        ).map { _ in
            return ()
        }.catch { error in
            if let moyaError = error as? MoyaError {
                switch moyaError.errorCode {
                case 401: return Single.error(WalkhubError.unauthorization)
                default: return Single.error(error)
                }
            } else { return Single.error(error) }
        }
    }
    
    func findID(phoneNumber: String) -> Single<FindUserIdDTO> {
        return UserService.shared.findID(phoneNumber: phoneNumber)
            .map(FindUserIdDTO.self)
            .map { return $0 }
            .catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError.errorCode {
                    case 404: return Single.error(WalkhubError.faildFound)
                    default: return Single.error(error)
                    }
                } else { return Single.error(error) }
            }
    }
    
    func writeHealth(height: Float, weight: Int) -> Single<Void> {
        return UserService.shared.writeHealth(height: height, weight: weight)
            .map { _ in
                return ()
            }.catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError.errorCode {
                    case 401: return Single.error(WalkhubError.unauthorization)
                    default: return Single.error(error)
                    }
                } else { return Single.error(error) }
            }
    }
    
    func joinClass(agencyCode: String, grade: Int, classNum: Int) -> Single<Void> {
        return UserService.shared.joinClass(
            agencyCode: agencyCode,
            grade: grade,
            classNum: classNum
        ).map { _ in
            return ()
        }.catch { error in
            if let moyaError = error as? MoyaError {
                switch moyaError.errorCode {
                case 401: return Single.error(WalkhubError.unauthorization)
                case 403: return Single.error(WalkhubError.forbidden)
                case 404: return Single.error(WalkhubError.faildFound)
                case 409: return Single.error(WalkhubError.duplicate)
                default: return Single.error(error)
                }
            } else { return Single.error(error) }
        }
    }
    
    func changeSchoolInformation(agencyCode: String) -> Single<Void> {
        return UserService.shared.changeSchoolInformation(agencyCode: agencyCode)
            .map { _ in
                return ()
            }.catch { error in
                if let moyaError = error as? MoyaError {
                    switch moyaError.errorCode {
                    case 401: return Single.error(WalkhubError.unauthorization)
                    default: return Single.error(error)
                    }
                } else { return Single.error(error) }
            }
    }
}
