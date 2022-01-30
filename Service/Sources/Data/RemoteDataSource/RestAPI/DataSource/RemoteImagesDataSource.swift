import Foundation

import Moya
import RxSwift

final class RemoteImagesDataSource: RestApiRemoteDataSource<ImagesAPI> {

    static let shared = RemoteImagesDataSource()

    private override init() { }

    func postImages(images: [Data]) -> Single<Response> {
        return request(.postImages(images: images))
    }

}
