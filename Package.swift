// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "ReactiveTuto",
    products: [],
    dependencies: [
        // add your dependencies here, for example:
        // .package(url: "https://github.com/User/Project.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "14.0.0"))
    ],
    targets: [
        .target(
            name: "ReactiveTuto",
            dependencies: [
                // add your dependencies scheme names here, for example:
                // "Project",
                "Moya"
            ],
            path: "ReactiveTuto"
        ),
    ]
)
