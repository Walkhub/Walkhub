import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: [
        .remote(
            url: "https://github.com/ReactiveX/RxSwift",
            requirement: .upToNextMajor(from: "6.2.0")
        ),
        .remote(
            url: "https://github.com/realm/realm-cocoa.git",
            requirement: .upToNextMajor(from: "10.20.2")
        ),
        .remote(
            url: "https://github.com/Moya/Moya.git",
            requirement: .upToNextMajor(from: "15.0.0")
        ),
        .remote(
            url: "https://github.com/devxoul/Then.git",
            requirement: .upToNextMajor(from: "2.7.0")
        ),
        .remote(
            url: "https://github.com/Swinject/Swinject.git",
            requirement: .upToNextMajor(from: "2.8.0")
        ),
        .remote(
            url: "https://github.com/layoutBox/PinLayout.git",
            requirement: .upToNextMajor(from: "1.10.0")
        ),
        .remote(
            url: "https://github.com/layoutBox/FlexLayout.git",
            requirement: .upToNextMajor(from: "1.3.23")
        )
    ],
    platforms: [.iOS]
)
