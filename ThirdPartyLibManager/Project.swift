import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
    name: "ThirdPartyLibManager",
    packages: [
        .RxSwift,
        .Realm,
        .Moya,
        .Then,
        .Swinject,
        .SnapKit,
        .Firebase,
        .SocketIO,
        .KDCircularProgress,
        .Charts
    ],
    dependencies: [
        .SPM.RxSwift,
        .SPM.Realm,
        .SPM.RealmSwift,
        .SPM.RxCocoa,
        .SPM.RxMoya,
        .SPM.Then,
        .SPM.Swinject,
        .SPM.SnapKit,
        .SPM.FCM,
        .SPM.SocketIO,
        .SPM.KDCircularProgress,
        .SPM.Charts
    ]
)
