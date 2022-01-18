import Foundation

import Moya

enum NoticesAPI {
    case fetchNotice
    case writeNotice(title: String, content: String, scope: String)
    case deleteNotice(noticeID: Int)
}

extension NoticesAPI: WalkhubAPI {
    var domain: ApiDomain {
        .notices
    }
    
    var urlPath: String {
        switch self {
        case .fetchNotice:
            return "/list"
        case .deleteNotice(let noticeID):
            return "/\(noticeID)"
        default:
            return "/"
        }
    }
    
    var task: Task {
        switch self {
        case .writeNotice(let title, let content, let scope):
            return .requestParameters(
                parameters: [
                    "title": title,
                    "content": content,
                    "scope": scope
                ],
                encoding: JSONEncoding.prettyPrinted
            )
        default:
            return .requestPlain
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchNotice:
            return .get
        case .deleteNotice:
            return .delete
        default:
            return .post
        }
    }
    
    var jwtTokenType: JWTTokenType? {
        return .accessToken
    }
    
    
}
