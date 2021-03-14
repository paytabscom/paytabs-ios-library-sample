Pod::Spec.new do |s|
  s.name         = "ClickPay"
  s.version      = "6.0.7-beta"
  s.summary      = "ClickPay is an online payment gateway."
  s.ios.deployment_target = '10.0'
  s.homepage     = "https://github.com/paytabscom/paytabs-ios-library-sample/tree/clickpay"
  s.license      = "MIT"
  s.author       = { "PayTabs" => "m.adly@paytabs.com" }
  s.source   = { :git => 'https://github.com/paytabscom/paytabs-ios-library-sample.git', :tag => s.version.to_s }
  
  s.ios.vendored_frameworks = 'sources/PaymentSDK.framework'
  s.xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => "'${PODS_ROOT}'/sources/**", 'SWIFT_INCLUDE_PATHS' => "'${PODS_TARGET_SRCROOT}'/sources/**"}

end
