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
    case signupIsRequired

    // Login
    case loginIsRequired
    case userIsLoggedIn
    case findIdIsRequired
    case changePasswordIsRequired

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

    // Setting
    case settingIsRequired
    case editProfileIsRequired
    case editHealthInformationIsRequired
    case accountInformationIsRequired
    case backEditProfileScene
}
