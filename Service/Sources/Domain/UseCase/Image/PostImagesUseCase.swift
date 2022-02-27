import Foundation

import RxSwift

public class PostImageUseCase {

    private let imageRepository: ImageRepository

    init(imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }

    public func excute(images: [Data]) -> Single<[URL]> {
        return imageRepository.postImages(images: images)
    }
}
