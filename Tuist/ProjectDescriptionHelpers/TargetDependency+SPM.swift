import ProjectDescription

extension TargetDependency {
    public struct SPM { }
}

public extension TargetDependency.SPM {
    static let RxSwift = TargetDependency.external(name: "RxSwift")
    static let Realm = TargetDependency.external(name: "Realm")
    static let RxCoca = TargetDependency.external(name: "RxCoca")
    static let RxMoya = TargetDependency.external(name: "RxMoya")
    static let Then = TargetDependency.external(name: "Then")
    static let Swinject = TargetDependency.external(name: "Swinject")
    static let PinLayout = TargetDependency.external(name: "PinLayout")
    static let FlexLayout = TargetDependency.external(name: "FlexLayout")
}
