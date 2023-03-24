#
# Be sure to run `pod lib lint TFUILib_iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TFUILib_iOS'
  s.version          = '1.1.9'
  s.summary          = 'UI lib for Treasure framework.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
UI lib for Treasure framework.
                       DESC

  s.homepage         = 'https://github.com/loverbabyz/TFUILib_iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SunXiaofei' => 'daniel.xiaofei@gmail.com' }
  s.source           = { :git => 'https://github.com/loverbabyz/TFUILib_iOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.requires_arc = true
  
  s.source_files = 'TFUILib_iOS/Classes/**/*'
  # s.public_header_files = 'TFUILib_iOS/Classes/TFUILib_iOS.h'
  # s.source_files = 'TFUILib_iOS/Classes/TFUILib_iOS.h'
  
  # s.resource_bundles = {
  #   'TFUILib_iOS' => ['TFUILib_iOS/Assets/*.png']
  # }
  
  # s.framework  = "frameworkname"
  # s.library   = "libraryname"
  # s.vendored_libraries = "TFUILib_iOS/Classes/**/*.{a}"
  # s.ios.libraries = "stdc++", "sqlite3"
  # s.ios.vendored_frameworks = "TFUILib_iOS/Classes/3rd-framework/**/*.{framework}"
  
  s.resources = "TFUILib_iOS/Assets/**/*.{bundle}"
  s.frameworks = "Foundation", "UIKit", "CoreGraphics", "CoreData", "CoreText", "ImageIO", "QuartzCore", "WebKit", "AVFoundation", "Photos", "AudioToolbox", "MapKit", "CoreLocation", "SceneKit"
  s.xcconfig = {
      'OTHER_LDFLAGS' => '-ObjC -all_load -force_load'
  }
  
  s.dependency 'TFBaseLib_iOS'
  s.dependency 'MJRefresh'
  s.dependency 'Masonry'

end
