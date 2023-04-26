// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PresentationLayer",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PresentationLayer",
            targets: ["PresentationLayer"])
    ],
    dependencies: [
        .package(path: "../DILayer"),
        .package(path: "../PlatformLayer"),
        .package(path: "../DomainLayer"),
        .package(url: "https://github.com/ReactiveX/RxSwift", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/RxSwiftCommunity/RxSwiftExt", .upToNextMajor(from: "6.0.0")),
        .package(url: "https://github.com/RxSwiftCommunity/RxFlow", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/SnapKit/SnapKit", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/devxoul/Then", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/onevcat/Kingfisher", .upToNextMajor(from: "7.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "PresentationLayer",
            dependencies: [
                .product(name: "DILayer", package: "DILayer"),
                .product(name: "TSCore", package: "PlatformLayer"),
                .product(name: "TSCoreUI", package: "PlatformLayer"),
                .product(name: "DomainLayer", package: "DomainLayer"),
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "RxSwiftExt", package: "RxSwiftExt"),
                .product(name: "RxFlow", package: "RxFlow"),
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "Then", package: "Then"),
                .product(name: "Kingfisher", package: "Kingfisher")
            ]
        ),
        .testTarget(
            name: "PresentationTests",
            dependencies: [
                "PresentationLayer",
                .product(name: "TSTestUtility", package: "PlatformLayer"),
                .product(name: "RxTest", package: "RxSwift")
            ]
        )
    ]
)
