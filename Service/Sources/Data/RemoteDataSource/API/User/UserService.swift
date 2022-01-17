import Foundation

import Moya
import RxSwift

final class UserService: BaseService<UserAPI> {
    
    static let shared = UserService()
    
    private override init() {}
    
    func changePassword(
        accountID: String,
        phoneNumber: String,
        authCode: String,
        newPassword: String
    ) -> Single<Response> {
        return request(.changePassword(
            accountID: accountID,
            phoneNumber: phoneNumber,
            authCode: authCode,
            newPassword: newPassword
        ))
    }
    
    func profileInquiry(userID: Int) -> Single<Response> {
        return request(.profileInquiry(userID: userID))
    }
    
    func myPageInquiry() -> Single<Response> {
        return request(.myPageInquiry)
    }
    
    func mainBadgeSet(badgeID: Int) -> Single<Response> {
        return request(.mainBadgeSet(badgeID: badgeID))
    }
    
    func changeProfile(
        name: String,
        profileImageUrlString: String,
        birthday: String,
        sex: String
    ) -> Single<Response> {
        return request(.changeProfile(
            name: name,
            profileImageUrlString: profileImageUrlString,
            birthday: birthday,
            sex: sex
        ))
    }
    
    func findID(phoneNumber: String) -> Single<Response> {
        return request(.findID(phoneNumber: phoneNumber))
    }
    
    func writeHealth(
        height: Float,
        weight: Int
    ) -> Single<Response> {
        return request(.writeHealth(
            height: height,
            weight: weight
        ))
    }
    
    func joinClass(
        agencyCode: String,
        grade: Int,
        classNum: Int
    ) -> Single<Response> {
        return request(.joinClass(
            agencyCode: agencyCode,
            grade: grade,
            class: classNum
        ))
    }
}
