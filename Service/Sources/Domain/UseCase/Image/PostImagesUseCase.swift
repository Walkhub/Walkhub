import Foundation

import RxSwift

public class PostImageUseCase {

    private let imageRepository: ImageRepository

    init(imageRepository: ImageRepository) {
        self.imageRepository = imageRepository
    }

    public func excute(images: [Data]) -> Observable<[String]> {
        return imageRepository.postImages(images: images).map { $0.map { $0.absoluteString } }
    }
}
