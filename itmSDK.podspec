#
# Be sure to run `pod lib lint itmSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'itmSDK'
  s.version          = '0.3.1'
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
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Clintlin' => 'linguanjie@gmail.com' }
  # s.source           = { :git => 'https://github.com/Clintlin/itmSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'



  # # 模块bbb
  # s.subspec 'Framework' do |ss|

  #     # ss.source_files = 'itmSDK/**/**'
  #     # ss.public_header_files = 'itmSDK/**/Headers/itmSDK.h'

  #     # ss.dependency 'AAA/aaa'
  # end

  s.ios.vendored_frameworks = 'Frameworks/itmSDK.framework'
  # s.source_files = 'itmSDK/**'
  # s.preserve_paths = 'itmSDK/itmSDK.framework'

s.source       = { :git => 'https://github.com/Clintlin/itmSDK.git', :tag => s.version.to_s, :commit => "master" }
# s.source_files  = 'Classes/*.{h,m}'


  s.framework = 'UIKit'
  s.dependency 'AFNetworking', '~> 3.1.0'
  s.dependency 'Masonry', '~> 1.0.2'
  s.dependency 'MBProgressHUD', '~> 1.0.0'

  # s.resource_bundles = {
  #   'itmSDK' => ['itmSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
