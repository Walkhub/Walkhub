import Foundation

import CoreLocation
import RxSwift

final class CoreLocationDataSource: NSObject, CLLocationManagerDelegate {

    static let shared = CoreLocationDataSource()

    private let locationManager = CLLocationManager()

    let liveUserLocation = PublishSubject<UserLocation>()

    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 5
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
    }

    func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
    }

    func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        let lastLocation = locations.last
        let latitude = lastLocation?.coordinate.latitude
        let longitude = lastLocation?.coordinate.longitude
        self.liveUserLocation.onNext(UserLocation(latitude: latitude!, longitude: longitude!))
    }

}
