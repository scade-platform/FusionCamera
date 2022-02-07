// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FusionCamera",
    platforms: [.macOS(.v10_14), .iOS(.v13)],
    products: [
        .library(
            name: "FusionCamera",
            targets: ["FusionCamera"]),
    ],
    dependencies: [
        //.package(name: "Android", url: "https://github.com/scade-platform/swift-android.git", .branch("android/24"))        
    ],
    targets: [
        .target(
            name: "FusionCamera",
            dependencies: [
              .target(name: "FusionCamera_Common"),              
              .target(name: "FusionCamera_Apple", condition: .when(platforms: [.iOS, .macOS])),
              //.target(name: "FusionCamera_Android", condition: .when(platforms: [.android])),
            ]            
        ),
        .target(
            name: "FusionCamera_Common"
        ),        
        .target(
            name: "FusionCamera_Apple",
            dependencies: [
              .target(name: "FusionCamera_Common"),
            ]                        
        ),            	
        // .target(
        //     name: "FusionCamera_Android",
        //     dependencies: [
        //       .target(name: "FusionCamera_Common"),
        //       .product(name: "Android", package: "Android", condition: .when(platforms: [.android])),
        //       .product(name: "AndroidOS", package: "Android", condition: .when(platforms: [.android])),
        //       .product(name: "AndroidNFC", package: "Android", condition: .when(platforms: [.android]))              
        //     ],
        //     resources: [.copy("Generated/NFCReceiver.java")]
        // )
    ]
)

