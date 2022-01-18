import ProjectDescription

extension Project {

    public static func dynamicFramework(
        name: String,
        platform: Platform = .iOS,
        packages: [Package] = [],
        infoPlist: InfoPlist = .default,
        dependencies: [TargetDependency] = [
            .project(target: "ThirdPartyLibManager", path: "../ThirdPartyLibManager")
        ]
    ) -> Project {
        return Project(
            name: name,
            packages: packages,
            settings: .settings(base: .codeSign),
            targets: [
                Target(
                    name: name,
                    platform: platform,
                    product: .framework,
                    bundleId: "\(xquareOrganizationName).\(name)",
                    deploymentTarget: .iOS(
                        targetVersion: "13.0",
                        devices: [.iphone, .ipad]
                    ),
                    infoPlist: infoPlist,
                    sources: ["Sources/**"],
                    scripts: [.swiftlint],
                    dependencies: dependencies
                )
            ]
        )
    }

}
