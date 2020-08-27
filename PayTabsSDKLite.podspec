Pod::Spec.new do |s|
  s.name         = "PayTabsSDKLite"
  s.version      = "4.0.9"
  s.summary      = "PayTabs is an online payment gateway."
  s.ios.deployment_target = '9.0'
  s.homepage     = "http://www.paytabs.com"
  s.license      = "MIT"
  s.author       = { "PayTabs" => "m.adly@paytabs.com" }
  s.source       = { :path => '.' }
#  s.source   = { :git => 'https://github.com/paytabscom/paytabs-ios-library-sample.git', :tag => s.version }

  s.source_files  = "sdk_lite/paytabs-iOS.framework"
  s.resources = "resources/Resources.bundle"
  s.ios.vendored_frameworks = 'sdk_lite/paytabs-iOS.framework'
  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => "'${PODS_ROOT}'/sdk_lite/**", 'SWIFT_INCLUDE_PATHS' => "'${PODS_TARGET_SRCROOT}'/sdk_lite/**"}

  s.dependency 'BIObjCHelpers'
  s.dependency 'IQKeyboardManager'
  s.dependency 'AFNetworking', '> 4.0.0'
  s.dependency 'Mantle'
  s.dependency 'Reachability'
  s.dependency 'Lockbox'
  s.dependency 'SBJson'
  s.dependency 'PINCache'
  s.dependency 'MBProgressHUD'
  s.dependency 'ActionSheetPicker-3.0'
end
