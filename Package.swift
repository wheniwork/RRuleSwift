// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RRuleSwift",
    products: [
        .library(
            name: "RRuleSwift",
            targets: ["RRuleSwift-iOS"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RRuleSwift-iOS",
            dependencies: [],
            resources: [
                .process("lib/nlp.js"),
                .process("lib/rrule.js")
            ]
        )
    ]
)
