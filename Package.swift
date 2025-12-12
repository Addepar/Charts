// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "DGCharts",
    platforms: [
          .iOS(.v8),
          .tvOS(.v9),
          .macOS(.v10_11),
    ],
    products: [
        .library(
            name: "DGCharts",
            targets: ["Charts"]),
    ],
    targets: [
        .target(name: "Charts")
    ],
    swiftLanguageVersions: [.v5]
)
