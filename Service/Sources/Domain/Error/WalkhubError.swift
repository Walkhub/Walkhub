import Foundation

public enum WalkhubError: Error {

    // Base
    case noInternet
    case unauthorization

    // Auth
    case invalidAuthCode
    case duplicateId
    case wrongId
    case wrongPassword
    case wrongPhoneNumber

    // User
    case inaccessibleClass
    case undefinededClass
    case alreadyJoinedClass
    case undefinededSchool
    
    // Challenges
    case inaccessibleChallenge
    case undefinededChallenge
    case alreadyJoinedChallenge
}

extension WalkhubError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noInternet:
            return "인터넷이 없습니다."
        case .unauthorization:
            return "토큰 인증에 실패하였습니다."
        case .invalidAuthCode:
            return "Auth Code가 만료되었습니다."
        case .duplicateId:
            return "중복된 ID 입니다."
        case .wrongId:
            return "ID가 틀렸습니다."
        case .wrongPassword:
            return "비밀번호가 틀렸습니다."
        case .wrongPhoneNumber:
            return "전화번호가 잘못되었습니다."
        case .inaccessibleClass:
            return "해당 반이 유저의 학교 소속이 아닌 등의 이유로 접근할 수 없습니다."
        case .undefinededClass:
            return "해당 반을 찾을 수 없습니다."
        case .alreadyJoinedClass:
            return "해당 반에 이미 가입 되어있습니다."
        case .undefinededSchool:
            return "해당 학교를 찾을 수 없습니다."
        case .inaccessibleChallenge:
            return "해당 챌린지에 접근할 수 없습니다."
        case .undefinededChallenge:
            return "해당 챌린지를 찾을 수 없습니다."
        case .alreadyJoinedChallenge:
            return "해당 챌린지에 이미 참여 되어있습니다."
        }
    }
}
