Pod::Spec.new do |s|
  s.name         = "PayTabsSDK"
  s.version      = "4.0.10.rc.1"
  s.summary      = "PayTabs is an online payment gateway."
  s.ios.deployment_target = '9.0'
  s.homepage     = "https://github.com/paytabscom/paytabs-ios-library-sample/tree/cocoapods_support"
  s.license      = "MIT"
  s.author       = { "PayTabs" => "m.adly@paytabs.com" }
  s.source   = { :git => 'https://github.com/paytabscom/paytabs-ios-library-sample.git', :tag => s.version.to_s }

  s.resources = "resources/Resources.bundle"
  s.ios.vendored_frameworks = 'sdk_ocr/paytabs-iOS.framework'
  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => "'${PODS_ROOT}'/sdk_ocr/**", 'SWIFT_INCLUDE_PATHS' => "'${PODS_TARGET_SRCROOT}'/sdk_ocr/**"}
  
  s.dependency 'BIObjCHelpers', '~> 0.4.3'
  s.dependency 'IQKeyboardManager'
  s.dependency 'AFNetworking', '~> 4.0.1'
  s.dependency 'Mantle', '~> 2.1.0'
  s.dependency 'Reachability', '~> 3.2'
  s.dependency 'Lockbox', '~> 3.0.6'
  s.dependency 'SBJson', '~> 5.0.0'
  s.dependency 'PINCache', '~> 2.3'
  s.dependency 'MBProgressHUD', '~> 1.1.0'
  s.dependency 'ActionSheetPicker-3.0', '~> 2.4.2'
  s.dependency 'PayCardsRecognizer'

end
