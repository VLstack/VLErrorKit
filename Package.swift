// swift-tools-version: 6.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: [ SwiftSetting ] =
[
 .enableUpcomingFeature("ApproachableConcurrency"),
 .enableUpcomingFeature("MemberImportVisibility"),
 .enableUpcomingFeature("ExistentialAny")
]

let package = Package(name: "VLErrorKit",
                      defaultLocalization: "en",
                      platforms: [ .iOS(.v17) ],
                      products:
                      [
                       .library(name: "VLErrorKit",
                                targets: [ "VLErrorKit" ])
                      ],
                      targets:
                      [
                       .target(name: "VLErrorKit",
                               resources: [ .process("Resources") ],
                               swiftSettings: swiftSettings),
                       .testTarget(name: "VLErrorKitTests",
                                   dependencies: [ "VLErrorKit" ],
                                   swiftSettings: swiftSettings)
                      ])
