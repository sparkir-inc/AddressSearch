#
#  Be sure to run `pod spec lint AddressSearch.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         		= "AddressSearch"
  spec.version      		= "1.0"
  spec.summary      		= "AddressSearch provides a seamless address autocomplete framework"

  spec.homepage     		= "https://github.com/sparkir-inc/AddressSearch"
  spec.license      		= "MIT"
  spec.author       		= "sparkir-inc"
  spec.platform     		= :ios, "11.0"

  spec.source       		= { :git => "https://github.com/sparkir-inc/AddressSearch.git", :tag => "v#{spec.version}" }

  spec.source_files  			= 'AddressSearch', 'AddressSearch/**/*.{h,m,swift}'
  spec.resource_bundles 		= { 'AddressSearch' => ['AddressSearch/*.{storyboard,xib,png}'] }

  spec.pod_target_xcconfig = { 'SWIFT_VERSION' => '5' }
  spec.swift_version = '5'

end
