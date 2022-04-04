import Foundation

import RxSwift

protocol CheeringRepository {
    func cheering(userID: Int)
    func observingCheering() -> Observable<String>
}
