import Foundation

import RxSwift

protocol ImageRepository {
    func postImages(images: [Data]) -> Observable<[URL]>
}
