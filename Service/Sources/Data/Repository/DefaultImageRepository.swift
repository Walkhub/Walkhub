import Foundation

import RxSwift

class DefaultImageRepository: ImageRepository {
    func postImages(images: [Data]) -> Single<[URL]> {
        return RemoteImageDataSource.shared.postImages(images: images)
    }
}
