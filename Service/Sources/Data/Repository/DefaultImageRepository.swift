import Foundation

import RxSwift

class DefaultImageRepository: ImageRepository {

    private let remoteImageDataSource = RemoteImageDataSource.shared

    func postImages(images: [Data]) -> Single<[URL]> {
        return RemoteImageDataSource.shared.postImages(images: images)
    }

}
