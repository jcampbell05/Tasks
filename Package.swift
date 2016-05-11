import PackageDescription

let package = Package(
    name: "Tasks",
    targets: [Target(name: "TasksExample", dependencies: [.Target(name: "Tasks")])]
)
