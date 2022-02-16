import Foundation

import RxFlow

enum WalkhubStep: Step {

    // Application
    case tabsIsRequired
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

    // Hub
    case hubIsRequired

    // Challenge
    case challengeIsRequired

    // Profile
    case profileIsRequired

}
