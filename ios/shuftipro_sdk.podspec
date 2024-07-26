#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint shuftipro_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'shuftipro_sdk'
  s.version          = '3.7.4'
  s.summary          = 'ShuftiPro Flutter SDK'
  s.description      = "<<-DESCA new Flutter project. DESC"
  s.homepage         = 'http://shuftipro.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Shuftipro' => 'support@shuftipro.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency  'ShuftiPro' , '~> 3.7.4'

  s.platform = :ios, '13.0'
  s.source = { :git => 'https://github.com/shuftipro/iOS-binary-pod', :tag => s.version }
  


  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
#  s.preserve_paths = 'ShuftiPro.xcframework'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework ShuftiPro' }
 # s.vendored_frameworks = 'ShuftiPro.xcframework'
  
end
