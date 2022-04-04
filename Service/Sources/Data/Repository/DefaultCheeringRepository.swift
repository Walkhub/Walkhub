import Foundation

import RxSwift

class DefaultCheeringRepository: CheeringRepository {

    private let remoteCheeringDataSource = RemoteCheeringDataSource.shared

    func cheering(userID: Int) {
        remoteCheeringDataSource.cheering(userID: userID)
    }
    
    func observingCheering() -> Observable<String> {
        remoteCheeringDataSource.observingCheering()
    }

}
