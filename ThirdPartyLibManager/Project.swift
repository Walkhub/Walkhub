import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.dynamicFramework(
    name: "ThirdPartyLibManager",
    dependencies: [
        .SPM.RxSwift,
        .SPM.Realm,
        .SPM.RxCoca,
        .SPM.RxMoya,
        .SPM.Then,
        .SPM.Swinject,
        .SPM.PinLayout,
        .SPM.FlexLayout
    ]
)
