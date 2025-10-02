// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "VLErrorKit",
                      defaultLocalization: "en",
                      platforms: [ .iOS(.v17) ],
                      products:
                      [
                       .library(name: "VLErrorKit",
                                targets: [ "VLErrorKit" ])
                      ],
                      dependencies:
                      [
                       .package(url: "https://github.com/VLstack/VLstackNamespace", from: "1.2.0"),
                       .package(url: "https://github.com/VLstack/VLBundleKit", from: "1.5.1"),
                       .package(url: "https://github.com/VLstack/VLSFSymbolKit", from: "2.10.1"),
                       .package(url: "https://github.com/VLstack/VLColorKit", from: "3.1.0")
                      ],
                      targets:
                      [
                       .target(name: "VLErrorKit",
                               dependencies: [ "VLstackNamespace", "VLBundleKit", "VLSFSymbolKit", "VLColorKit" ],
                               resources: [ .process("Resources") ])
                      ])
