import ProjectDescription

extension TargetScript {
    static let swiftlint = TargetScript.pre(
        script: "\"$SRCROOT\"/SwiftLintRunScript.sh",
        name: "SwiftLint"
    )
}
