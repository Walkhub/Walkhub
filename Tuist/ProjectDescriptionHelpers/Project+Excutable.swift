import ProjectDescription

extension Project {

    public static func excutable(
        name: String,
        platform: Platform,
        product: Product = .app,
        dependencies: [TargetDependency]
    ) -> Project {
        return Project(
            name: name,
            organizationName: xquareOrganizationName,
            targets: [
                Target(
                    name: name,
                    platform: platform,
                    product: product,
                    bundleId: "\(xquareOrganizationName).\(name)",
                    infoPlist: .file(path: Path("Info.plist")),
                    sources: ["Sources/**"],
                    resources: ["Resources/**"],
                    entitlements: Path("SupportingFiles/\(name).entitlements"),
                    scripts: [.swiftlint],
                    dependencies: [
                        .project(target: "ThirdPartyLibManager", path: "../ThirdPartyLibManager")
                    ] + dependencies
                )
            ]
        )
    }

}
