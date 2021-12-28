import ProjectDescription

extension TargetDependency {
    public struct SPM { }
}

public extension TargetDependency.SPM {
    static let RxSwift = TargetDependency.package(product: "RxSwift")
    static let Realm = TargetDependency.package(product: "Realm")
    static let RxCocoa = TargetDependency.package(product: "RxCocoa")
    static let RxMoya = TargetDependency.package(product: "RxMoya")
    static let Then = TargetDependency.package(product: "Then")
    static let Swinject = TargetDependency.package(product: "Swinject")
    static let PinLayout = TargetDependency.package(product: "PinLayout")
    static let FlexLayout = TargetDependency.package(product: "FlexLayout")
}

public extension Package {

    // remote spm
    static let RxSwift = Package.remote(
        url: "https://github.com/ReactiveX/RxSwift",
        requirement: .upToNextMajor(from: "6.2.0")
    )
    static let Realm = Package.remote(
        url: "https://github.com/realm/realm-cocoa.git",
        requirement: .upToNextMajor(from: "10.20.2")
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
    static let PinLayout = Package.remote(
        url: "https://github.com/layoutBox/PinLayout.git",
        requirement: .upToNextMajor(from: "1.10.0")
    )
    static let FlexLayout = Package.remote(
        url: "https://github.com/layoutBox/FlexLayout.git",
        requirement: .upToNextMajor(from: "1.3.23")
    )

}
