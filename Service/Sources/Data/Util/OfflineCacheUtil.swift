import Foundation

import RxCocoa
import RxSwift

class OfflineCacheUtil<T: Equatable> {

    private var fetchLocalData: (() -> Single<T>)!
    private var fetchRemoteData: (() -> Single<T>)!
    private var isNeedRefresh: (_ localData: T, _ remoteData: T) -> Bool = { $0 != $1 }
    private var refreshLocalData: ((_ remoteData: T) -> Void)!

    func localData(fetchLocalData: @escaping () -> Single<T>) -> Self {
        self.fetchLocalData = fetchLocalData
        return self
    }

    func remoteData(fetchRemoteData: @escaping () -> Single<T>) -> Self {
        self.fetchRemoteData = fetchRemoteData
        return self
    }

    func compareData(isNeedRefresh: @escaping (_ localData: T, _ remoteData: T) -> Bool) -> Self {
        self.isNeedRefresh = isNeedRefresh
        return self
    }

    func doOnNeedRefresh(refreshLocalData: @escaping (_ remoteData: T) -> Void) -> Self {
        self.refreshLocalData = refreshLocalData
        return self
    }

    func createObservable() -> Observable<T> {
        let local = fetchLocalData().asObservable().concat(Observable.never())
        let remote = fetchRemoteData().asObservable()
        return Observable<T>.create { observer in
            let localDisposable = local
                .catch{ _ in .never() }
                .bind(to: observer)
            let remoteDisposable = local
                .map { Optional($0) }
                .catchAndReturn(nil)
                .withLatestFrom(remote) { (local: $0, remote: $1) }
                .subscribe(onNext: {
                    if $0.local == nil || self.isNeedRefresh($0.local!, $0.remote) {
                        self.refreshLocalData($0.remote)
                        observer.onNext($0.remote)
                    }
                    observer.onCompleted()
                })
            return Disposables.create(localDisposable, remoteDisposable)
        }
    }

}
