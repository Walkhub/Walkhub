import Foundation

import RxFlow

enum WalkhubStep: Step {

    // Application
    case tabsIsRequired
    case alert(title: String, content: String)
    case unauthorized

    // Login
    case loginIsRequired
    case userIsLoggedIn

    // Home
    case homeIsRequired

    // Hub
    case hubIsRequired

    // Challenge
    case challengeIsRequired

    // Profile
    case profileIsRequired

}
