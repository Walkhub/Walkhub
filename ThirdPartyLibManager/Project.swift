import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
    name: "ThirdPartyLibManager",
    packages: [
        .RxSwift,
        .RxFlow,
        .Realm,
        .Moya,
        .Then,
        .Swinject,
        .SnapKit,
        .Firebase,
        .SocketIO,
        .KDCircularProgress,
        .Charts,
        .DropDown
    ],
    dependencies: [
        .SPM.RxSwift,
        .SPM.Realm,
        .SPM.RealmSwift,
        .SPM.RxCocoa,
        .SPM.RxFlow,
        .SPM.RxMoya,
        .SPM.Then,
        .SPM.Swinject,
        .SPM.SnapKit,
        .SPM.FCM,
        .SPM.SocketIO,
        .SPM.KDCircularProgress,
        .SPM.Charts,
        .SPM.DropDown
    ]
)
