// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PayTabsSDK",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "PaymentSDK",
            targets: ["PaymentSDK"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .binaryTarget(name: "PaymentSDK", url: "https://github.com/amr-Magdy-PT/paytabs-ios-library-sample/blob/master/sources/PaymentSDK.xcframework.zip", checksum: "2d904fb85aa0b1873061f4eb1323ce60d412a28dd04b55579820ba908b8d3aa3")
    ]
)
