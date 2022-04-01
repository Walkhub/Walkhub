import ProjectDescription

extension TargetDependency {
    public struct SPM { }
}

public extension TargetDependency.SPM {
    static let RxSwift = TargetDependency.package(product: "RxSwift")
    static let RxCocoa = TargetDependency.package(product: "RxCocoa")
    static let RxFlow = TargetDependency.package(product: "RxFlow")
    static let Realm = TargetDependency.package(product: "Realm")
    static let RealmSwift = TargetDependency.package(product: "RealmSwift")
    static let RxMoya = TargetDependency.package(product: "RxMoya")
    static let Then = TargetDependency.package(product: "Then")
    static let Swinject = TargetDependency.package(product: "Swinject")
    static let SnapKit = TargetDependency.package(product: "SnapKit")
    static let FCM = TargetDependency.package(product: "FirebaseMessaging")
    static let SocketIO = TargetDependency.package(product: "SocketIO")
    static let KDCircularProgress = TargetDependency.package(product: "KDCircularProgress")
    static let Charts = TargetDependency.package(product: "Charts")
    static let DropDown = TargetDependency.package(product: "DropDown")
    static let Tabman = TargetDependency.package(product: "Tabman")
    static let Loaf = TargetDependency.package(product: "Loaf")
    static let Kingfisher = TargetDependency.package(product: "Kingfisher")
}

public extension Package {

    // remote spm
    static let RxSwift = Package.remote(
        url: "https://github.com/ReactiveX/RxSwift",
        requirement: .upToNextMajor(from: "6.2.0")
    )
    static let RxFlow = Package.remote(
        url: "https://github.com/RxSwiftCommunity/RxFlow.git",
        requirement: .upToNextMajor(from: "2.10.0")
    )
    static let Realm = Package.remote(
        url: "https://github.com/realm/realm-cocoa.git",
        requirement: .upToNextMajor(from: "10.25.0")
    )
    static let Moya = Package.remote(
        url: "https://github.com/Moya/Moya.git",
        requirement: .upToNextMajor(from: "15.0.0")
    )
    static let Then = Package.remote(
        url: "https://github.com/devxoul/Then.git",
        requirement: .upToNextMajor(from: "2.7.0")
    )
    static let Swinject = Package.remote(
        url: "https://github.com/Swinject/Swinject.git",
        requirement: .upToNextMajor(from: "2.8.0")
    )
    static let SnapKit = Package.remote(
        url: "https://github.com/SnapKit/SnapKit.git",
        requirement: .upToNextMajor(from: "5.0.1")
    )
    static let Firebase = Package.remote(
        url: "https://github.com/firebase/firebase-ios-sdk.git",
        requirement: .upToNextMajor(from: "8.10.0")
    )
    static let SocketIO = Package.remote(
        url: "https://github.com/socketio/socket.io-client-swift.git",
        requirement: .exact("15.2.0")
    )
    static let KDCircularProgress = Package.remote(
        url: "https://github.com/kaandedeoglu/KDCircularProgress",
        requirement: .upToNextMajor(from: "1.5.0")
    )
    static let Charts = Package.remote(
        url: "https://github.com/Walkhub/Charts",
        requirement: .exact("10.0.0")
    )
    static let DropDown = Package.remote(
        url: "https://github.com/AssistoLab/DropDown",
        requirement: .branch("master")
    )
    static let Tabman = Package.remote(
        url: "https://github.com/uias/Tabman",
        requirement: .upToNextMajor(from: "2.12.0")
    )
    static let Loaf = Package.remote(
        url: "https://github.com/schmidyy/Loaf.git",
        requirement: .upToNextMajor(from: "0.7.0")
    )
    static let Kingfisher = Package.remote(
        url: "https://github.com/onevcat/Kingfisher",
        requirement: .upToNextMajor(from: "7.2.0"))
}
