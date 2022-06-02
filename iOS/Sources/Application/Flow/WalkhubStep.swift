import Foundation

import Loaf
import RxFlow

enum WalkhubStep: Step {

    // Application
    case tabsIsRequired
    case loaf(_ message: String, state: Loaf.State, location: Loaf.Location)
    case alert(title: String, content: String)
    case unauthorized

    // Onboarding
    case onboardingIsRequired

    // Login
    case loginIsRequired
    case userIsLoggedIn
    case findIdIsRequired
    case changePasswordIsRequired

    // Signup
    case enterNameIsRequired
    case certigyPhoneNumberIsRequired(name: String)
    case authenticationNumberIsRequired(name: String, phoneNumber: String)
    case enterIdRequired(name: String, phoneNumber: String, authCode: String)
    case passwordIsRequired(name: String, phoneNumber: String, authCode: String, id: String)
    case setSchoolIsRequired(name: String, phoneNumber: String, authCode: String, id: String, password: String)
    case agreeIsRequired(name: String, phoneNumber: String, authCode: String, id: String, password: String, schoolId: Int)
    case enterHealthInfoIsRequired
    case personalInfoPolicyIsRequired
    case serviceUseTermsIsRequired

    // Home
    case homeIsRequired
    case activityAnalysisIsRequired
    case recordMeasurementIsRequired
    case notificationIsRequired

    // Hub
    case hubIsRequired
    case detailHubIsRequired(_ schoolId: Int, _ schoolName: String, _ isMySchool: Bool)
    case enterClassCodeIsRequired
    case joinClassIsRequired(_ classCode: String)
    case backToDetailHubIsScene

    // Challenge
    case challengeIsRequired

    // Profile
    case profileIsRequired

    // Record
    case playRecordIsRequired
    case timerIsRequired

<<<<<<< HEAD
    // Setting
    case settingIsRequired
    case editProfileIsRequired
    case editHealthInformationIsRequired
    case accountInformationIsRequired
    case searchSchoolIsRequired
    case backToScene
    case checkPasswordScene
    case changePasswordScene(pw: String)
    case notificationIsRequired
    case backToAccountScene
=======
    case none
>>>>>>> ff0db01b3db379d9c73b7b18b0e6b29b58ed9f34
}
