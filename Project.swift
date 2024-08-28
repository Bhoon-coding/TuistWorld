import ProjectDescription

private let bundleId: String = "com.bhoon.TuistWorld"
private let version: String = "0.0.1"
private let bundleVersion: String = "1"
private let iOSTargetVersion: String = "16.0"

private let basePath: String = "Targets/TuistWorld"
private let appName: String = "TuistWorld"

let project = Project(
    name: appName,
    settings: Settings.settings(configurations: makeConfigurations()),
    targets: [
        Target(
            name: appName,
            platform: .iOS,
            product: .app,
            bundleId: bundleId,
            deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: .iphone),
            infoPlist: makeInfoPlist(),
            sources: ["\(basePath)/Sources/**"],
            resources: ["\(basePath)/Resources/**"],
            settings: baseSettings()
        )
    ],
    additionalFiles: [
        "README.md"
    ]
)

/// extended plist 생성
/// - Returns: InfoPlist
private func makeInfoPlist(merging other: [String: InfoPlist.Value] = [:]) -> InfoPlist {
    var extendedPlist: [String: InfoPlist.Value] = [
        "UIApplicationSceneManifest": ["UIApplicationSupportsMultipleScenes": true],
        "UILaunchScreen": [],
        "UISupportedInterfaceOrientations": [
            "UIInterfaceOrientationPortrait",
        ],
        "CFBundleShortVersionString": "\(version)",
        "CFBundleVersion": "\(bundleVersion)",
        "CFBundleDisplayName": "${APP_DISPLAY_NAME}",
    ]
    
    other.forEach { (key: String, value: InfoPlist.Value) in
        extendedPlist[key] = value
    }
    
    return InfoPlist.extendingDefault(with: extendedPlist)
}

/// dev | release configuration 생성
/// - Returns: Configuration
private func makeConfigurations() -> [Configuration] {
    let debug: Configuration = .debug(name: "Debug", xcconfig: "Configs/Debug.xcconfig")
    let release: Configuration = .debug(name: "Release", xcconfig: "Configs/Release.xcconfig")
    
    return [debug, release]
}

private func baseSettings() -> Settings {
    var settings = SettingsDictionary()
    
    return Settings.settings(base: settings, configurations: [], defaultSettings: .recommended)
}
