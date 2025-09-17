// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XXHUD",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "XXHUD",
            targets: ["XXHUD"]
        ),
    ],
    targets: [
        .target(
            name: "XXHUD",
            path: "Sources/XXHUD"
        ),
        .testTarget(
            name: "XXHUDTests",
            dependencies: ["XXHUD"],
            path: "Tests/XXHUDTests"
        ),
    ]
)
