import Foundation

import Moya

enum ImageAPI {
    case postImages(images: [Data])
}

extension ImageAPI: WalkhubAPI {

    var domain: ApiDomain {
        return .images
    }

    var urlPath: String {
        return ""
    }

    var method: Moya.Method {
        return .post
    }

    var task: Task {
        switch self {
        case .postImages(let images):
            var multiformData = [MultipartFormData]()
            for index in images {
                multiformData.append(MultipartFormData(
                    provider: .data(index),
                    name: "images",
                    fileName: "image.jpg",
                    mimeType: "image/jpg"
                ))
            }
            return .uploadMultipart(multiformData)
        }
    }

    var jwtTokenType: JWTTokenType? {
        return .accessToken
    }

    var errorMapper: [Int: WalkhubError]? {
        return [
            401: .unauthorization
        ]
    }

}
