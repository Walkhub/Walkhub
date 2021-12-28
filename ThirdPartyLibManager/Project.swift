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
        .PinLayout,
        .FlexLayout
    ],
    dependencies: [
        .SPM.RxSwift,
        .SPM.Realm,
        .SPM.RxCocoa,
        .SPM.RxMoya,
        .SPM.Then,
        .SPM.Swinject,
        .SPM.PinLayout,
        .SPM.FlexLayout
    ]
)
