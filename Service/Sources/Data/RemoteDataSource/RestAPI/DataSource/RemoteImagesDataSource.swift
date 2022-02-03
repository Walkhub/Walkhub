import Foundation

import Moya
import RxSwift

final class RemoteImagesDataSource: RestApiRemoteDataSource<ImagesAPI> {

    static let shared = RemoteImagesDataSource()

    private override init() { }

    func postImages(images: [Data]) -> Single<[URL]> {
        return request(.postImages(images: images))
            .map(ImageUrlDTO.self)
            .map { $0.toDomain() }
    }

}
