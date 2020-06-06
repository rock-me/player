// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Player",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Player",
            targets: ["Player"]),
    ],
    targets: [
        .target(
            name: "Player",
            path: "Sources"),
        .testTarget(
            name: "Tests",
            dependencies: ["Player"],
            path: "Tests")
    ]
)
