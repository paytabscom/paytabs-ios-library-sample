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
        .binaryTarget(name: "PaymentSDK", url: "https://github.com/paytabscom/paytabs-ios-library-sample/raw/master/sources/PaymentSDK.xcframework.zip", checksum: "52685e25812df015fb5a62586434af017c30afdcb8fc616246f61611f236b9fb")
    ]
)
