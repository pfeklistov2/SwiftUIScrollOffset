// swift-tools-version: 5.10

/**
*  SwiftUIScrollOffset
*  Copyright (c) Ciaran O'Brien 2024
*  MIT license, see LICENSE file for details
*/

import PackageDescription

let package = Package(
    name: "SwiftUIScrollOffset",
    platforms: [
        .iOS(.v17),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "SwiftUIScrollOffset", targets: ["SwiftUIScrollOffset"])
    ],
    dependencies: [
        .package(url: "https://github.com/siteline/SwiftUI-Introspect", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "SwiftUIScrollOffset",
            dependencies: [.product(name: "SwiftUIIntrospect", package: "swiftui-introspect")]
        )
    ]
)
