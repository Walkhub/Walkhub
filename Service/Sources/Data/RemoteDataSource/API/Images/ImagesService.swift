import Foundation

import Moya
import RxSwift

final class ImagesService: BaseService<ImagesAPI> {
    
    static let shared = ImagesService()
    
    private override init() {}
    
    func postImages(images: [Data]) -> Single<Response> {
        return request(.postImages(images: images))
    }
}
