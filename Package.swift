// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "AgentBoard",
    platforms: [.macOS("26.0")],
    targets: [.executableTarget(name: "AgentBoard", path: "Sources/AgentBoard")]
)
