#
# Be sure to run `pod lib lint itmSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'itmSDK'
  s.version          = '0.3.3'
  s.summary          = 'fix document path bug'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This itmSDK for our project only.
                       DESC

  s.homepage         = 'https://github.com/Clintlin/itmSDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Clintlin' => 'linguanjie@gmail.com' }


  s.ios.deployment_target = '8.0'


  s.ios.vendored_frameworks = 'itmSDK/Frameworks/*.framework'
  s.source       = { :git => 'https://github.com/Clintlin/itmSDK.git', :tag => s.version.to_s, :commit => "master" }



  s.framework = 'UIKit'
  s.dependency 'AFNetworking', '~> 3.1.0'
  s.dependency 'Masonry', '~> 1.0.2'
  s.dependency 'MBProgressHUD', '~> 1.0.0'

end
