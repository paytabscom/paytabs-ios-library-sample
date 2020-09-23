Pod::Spec.new do |s|
 s.name         = "PayTabsSDKOCR"
  s.version      = "4.0.10"
  s.summary      = "PayTabs is an online payment gateway."
  s.ios.deployment_target = '9.0'
  s.homepage     = "https://github.com/paytabscom/paytabs-ios-library-sample.git"
  s.license      = "MIT"
  s.author       = { "PayTabs" => "m.adly@paytabs.com" }
  s.source   = { :git => 'https://github.com/paytabscom/paytabs-ios-library-sample.git', :tag => s.version }

  s.resources = "resources/Resources.bundle"
  s.ios.vendored_frameworks = 'sdk_ocr/paytabs-iOS.framework'
  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => "'${PODS_ROOT}'/sdk_ocr/**", 'SWIFT_INCLUDE_PATHS' => "'${PODS_TARGET_SRCROOT}'/sdk_ocr/**"}

  s.dependency 'BIObjCHelpers'
  s.dependency 'IQKeyboardManager'
  s.dependency 'AFNetworking', '4.0.1'
  s.dependency 'Mantle'
  s.dependency 'Reachability'
  s.dependency 'Lockbox'
  s.dependency 'SBJson'
  s.dependency 'PINCache'
  s.dependency 'MBProgressHUD'
  s.dependency 'ActionSheetPicker-3.0'
  s.dependency 'PayCardsRecognizer'

end
