// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DomainLayer",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DomainLayer",
            targets: ["DomainLayer"])
    ],
    dependencies: [
        .package(path: "../PlatformLayer"),
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: "6.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DomainLayer",
            dependencies: [
                .product(name: "TSCore", package: "PlatformLayer"),
                .product(name: "RxSwift", package: "RxSwift")
            ]
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: [
                "DomainLayer",
                .product(name: "TSTestUtility", package: "PlatformLayer"),
                .product(name: "RxBlocking", package: "RxSwift")
            ]
        )
    ]
)
