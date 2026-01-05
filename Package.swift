// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PayTabsSDK",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PayTabsSDK",
            targets: ["PaymentSDK"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .binaryTarget(name: "PaymentSDK", url: "https://github.com/paytabscom/paytabs-ios-library-sample/raw/master/sources/PaymentSDK.xcframework.zip", checksum: "2f394b5aac75e3b085849d16f7c7b58de17be1c6e7e209c0b92cfb6c71c8938f")
    ]
)
