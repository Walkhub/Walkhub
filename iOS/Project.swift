import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.excutable(
    name: "Walkhub",
    platform: .iOS,
    dependencies: [
        .project(target: "Service", path: "../Service")
    ]
)
