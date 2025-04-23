// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "VLErrorKit",
                      platforms: [ .iOS(.v17) ],
                      products:
                      [
                       .library(name: "VLErrorKit",
                                targets: [ "VLErrorKit" ])
                      ],
                      dependencies:
                      [
                       .package(url: "https://github.com/VLstack/VLstackNamespace", from: "1.1.1"),
                       .package(url: "https://github.com/VLstack/VLSFSymbolKit", from: "1.1.4"),
                       .package(url: "https://github.com/VLstack/VLColorKit", from: "1.3.0")
                      ],
                      targets:
                      [
                       .target(name: "VLErrorKit",
                               dependencies: [ "VLstackNamespace", "VLSFSymbolKit", "VLColorKit" ])
                      ])
