import Foundation

import Moya
import RxSwift

final class RemoteImageDataSource: RestApiRemoteDataSource<ImageAPI> {

    static let shared = RemoteImageDataSource()

    private override init() { }

    func postImages(images: [Data]) -> Observable<[URL]> {
        return request(.postImages(images: images))
            .map(ImageUrlDTO.self)
            .map { $0.toDomain() }
            .asObservable()
    }

}
