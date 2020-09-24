Pod::Spec.new do |s|
  s.name         = "PayTabs"
  s.version      = "4.1.0"
  s.summary      = "PayTabs is an online payment gateway."
  s.ios.deployment_target = '9.0'
  s.homepage     = "https://github.com/paytabscom/paytabs-ios-library-sample/tree/PT2"
  s.license      = "MIT"
  s.author       = { "PayTabs" => "m.adly@paytabs.com" }
  s.source   = { :git => 'https://github.com/paytabscom/paytabs-ios-library-sample.git', :tag => s.version.to_s }

  s.resources = "sources/Resources.bundle"
  s.ios.vendored_frameworks = 'sources/paytabs-iOS.framework'
  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => "'${PODS_ROOT}'/sources/**", 'SWIFT_INCLUDE_PATHS' => "'${PODS_TARGET_SRCROOT}'/sources/**"}

  s.dependency 'BIObjCHelpers', '~> 0.4.3'
  s.dependency 'AFNetworking', '~> 4.0.1'
  s.dependency 'Mantle', '~> 2.1.0'
  s.dependency 'Reachability', '~> 3.2'
  s.dependency 'Lockbox', '~> 3.0.6'
  s.dependency 'SBJson', '~> 5.0.0'
  s.dependency 'PINCache', '~> 2.3'
  s.dependency 'CardIO', '~> 5.4.1'
  s.dependency 'MBProgressHUD', '~> 1.1.0'
  s.dependency 'ActionSheetPicker-3.0', '~> 2.4.2'

end
