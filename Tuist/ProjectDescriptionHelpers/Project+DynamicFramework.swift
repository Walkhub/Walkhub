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
            targets: [
                Target(
                    name: name,
                    platform: platform,
                    product: .framework,
                    bundleId: "\(xquareOrganizationName).\(name)",
                    infoPlist: infoPlist,
                    sources: ["Sources/**"],
                    dependencies: dependencies
                )
            ]
        )
    }

}
