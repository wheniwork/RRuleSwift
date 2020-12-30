// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RRuleSwift",
    products: [
        .library(
            name: "RRuleSwift",
            targets: ["RRuleSwift"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RRuleSwift",
            dependencies: [],
            path: "Sources",
            exclude: [
                "Supporting Files/Info-iOS.plist",
                "Supporting Files/Info-watchOS.plist"
            ],
            resources: [
                .process("lib/nlp.js"),
                .process("lib/rrule.js")
            ]
        )
    ]
)
