// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Data",
            targets: ["Data"])
    ],
    dependencies: [
        .package(path: "../Platform"),
        .package(path: "../Domain"),
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/Moya/Moya", .upToNextMajor(from: "15.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Data",
            dependencies: [
                .product(name: "Platform", package: "Platform"),
                .product(name: "Domain", package: "Domain"),
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "Moya", package: "Moya"),
                .product(name: "RxMoya", package: "Moya")
            ]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"])
    ]
)
