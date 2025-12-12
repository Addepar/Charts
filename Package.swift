// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "Charts",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "DGCharts",
            targets: ["Charts"])
    ],
    targets: [
        .target(name: "Charts")
    ],
    swiftLanguageVersions: [.v5]
)
