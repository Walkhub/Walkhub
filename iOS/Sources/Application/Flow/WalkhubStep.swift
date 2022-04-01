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
    case certigyPhoneNumberIsRequired
    case authenticationNumberIsRequired(phoneNumber: String)
    case enterIdRequired
    case passwordIsRequired
    case setSchoolIsRequired
    case agreeIsRequired
    case enterHealthInfoIsRequired
    case personalInfoPolicyIsRequired
    case serviceUseTermsIsRequired

    // Home
    case homeIsRequired
    case activityAnalysisIsRequired
    case recordMeasurementIsRequired

    // Hub
    case hubIsRequired

    // Challenge
    case challengeIsRequired

    // Profile
    case profileIsRequired

    // Record
    case playRecordIsRequired
    case timerIsRequired
}
